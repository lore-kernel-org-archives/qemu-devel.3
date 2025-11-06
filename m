Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC42CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 04:22:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGrUu-0006kG-VG; Wed, 05 Nov 2025 23:21:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vGrUm-0006hG-TK
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:21:14 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vGrUk-0000q1-97
 for qemu-devel@nongnu.org; Wed, 05 Nov 2025 23:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762402870; x=1793938870;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HO69VW8SibDtUJN19KiXuNqVxAucPxaf7olQ7U4zi1w=;
 b=Y4B+m9TxWCEQUBSwahZ90g2Jxx5m6tVM4/dq1tsqz5XwhuGGfa0U/Oky
 ZpwsQyTDhC9ZT1M2WhwKUBllMBuq8K2DhDC7qA/lF4qTXD+0V3dsWucNK
 Y2uGoHIJuAc7N6v5rxiaewNWJUOcO51kiCO/6z8IGkfRtZN11n1vxpwL3
 Vfwp2QsuOnPu9BBIQ++XTh4A4ROGCV1CXAWmyogpP/PIJN9dJ598sDGeH
 UKH09eqoQXRY0rHPbx+0rb+Gskj89C8UvDuFFsg0XIq4/J3JxFRykma1t
 1O8hk7QIcKlZ8e5uTHz0QpFeO02WS03w6uQx8jAfT/Q4XLUifclhR72z9 Q==;
X-CSE-ConnectionGUID: fKGbkcetQTGiq+U1JLHdMw==
X-CSE-MsgGUID: T4RCqQKIQzuPu87W1vDxkw==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64412866"
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="64412866"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 20:21:09 -0800
X-CSE-ConnectionGUID: KPk2WzSPRO6kDwTzeZITjA==
X-CSE-MsgGUID: kUBxkFliSxa29y48KMdMWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,283,1754982000"; d="scan'208";a="186901289"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Nov 2025 20:21:06 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, mst@redhat.com, jasowang@redhat.com,
 yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, avihaih@nvidia.com,
 xudong.hao@intel.com, giovanni.cabiddu@intel.com, rohith.s.r@intel.com,
 mark.gross@intel.com, arjan.van.de.ven@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v5 7/9] vfio/listener: Construct iotlb entry when unmap memory
 address space
Date: Wed,  5 Nov 2025 23:20:24 -0500
Message-ID: <20251106042027.856594-8-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251106042027.856594-1-zhenzhong.duan@intel.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.517,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If a VFIO device in guest switches from passthrough(PT) domain to block
domain, the whole memory address space is unmapped, but we passed a NULL
iotlb entry to unmap_bitmap, then bitmap query didn't happen and we lost
dirty pages.

By constructing an iotlb entry with iova = gpa for unmap_bitmap, it can
set dirty bits correctly.

For IOMMU address space, we still send NULL iotlb because VFIO don't
know the actual mappings in guest. It's vIOMMU's responsibility to send
actual unmapping notifications, e.g., vtd_address_space_unmap_in_migration()

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
---
 hw/vfio/listener.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 2109101158..3b48f6796c 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -713,14 +713,27 @@ static void vfio_listener_region_del(MemoryListener *listener,
 
     if (try_unmap) {
         bool unmap_all = false;
+        IOMMUTLBEntry entry = {}, *iotlb = NULL;
 
         if (int128_eq(llsize, int128_2_64())) {
             assert(!iova);
             unmap_all = true;
             llsize = int128_zero();
         }
+
+        /*
+         * Fake an IOTLB entry for identity mapping which is needed by dirty
+         * tracking. In fact, in unmap_bitmap, only translated_addr field is
+         * used to set dirty bitmap.
+         */
+        if (!memory_region_is_iommu(section->mr)) {
+            entry.iova = iova;
+            entry.translated_addr = iova;
+            iotlb = &entry;
+        }
+
         ret = vfio_container_dma_unmap(bcontainer, iova, int128_get64(llsize),
-                                       NULL, unmap_all);
+                                       iotlb, unmap_all);
         if (ret) {
             error_report("vfio_container_dma_unmap(%p, 0x%"HWADDR_PRIx", "
                          "0x%"HWADDR_PRIx") = %d (%s)",
-- 
2.47.1


