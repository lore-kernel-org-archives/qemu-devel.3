Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2B0CAC5BA
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 02:26:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1y8L-00039a-FV; Thu, 25 Sep 2025 22:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y8I-00039N-Ju
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:24:27 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v1y86-0005UN-7H
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 22:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758853454; x=1790389454;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ebYHc0cw4clFH3u8D1IQESMDNchrLzdptMlQF+h2fB0=;
 b=ded0SuywCaf0fdbNCFfo+98DswpQNgvZG5v41gNDdNK4/K8CvUnd+qOv
 Le2e+l0vF/CDxB+oaNLHHU/ll0FKbNfJfGPegBg+YjWU/d8i5dLqiMFBT
 Bm0HzzisceKBM20nnWxixLf+aTfmByjq6ClRmabpRVYC3fqie/KQBW1UT
 1wUYST5hdABs6aOEYs4PB8oBYreKqneVk4/azJmiEuV77q+vwJtuuy+9x
 VPcukNyEtEwhmtl9KOnXVruoFGaxY2pltMYyOzktaOkA8S0NSk3e82DX4
 rLAtWQyndGTOuqUbqCZQ48vMoq+M35S0X1jfGS0NJR1+nv8J26VCVRSy7 w==;
X-CSE-ConnectionGUID: PXveDw11R9CC7RUeRYQYHQ==
X-CSE-MsgGUID: J1GWMbSJSVSSt6fM6r7oaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="61234088"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="61234088"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:24:06 -0700
X-CSE-ConnectionGUID: oQ/r1mIgQMOuy+6u86HWgA==
X-CSE-MsgGUID: ZsLfKcjsRa+FFbkOG7ASbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; d="scan'208";a="176613442"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Sep 2025 19:24:04 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH 2/5] vfio/cpr-legacy: drop an erroneous assert
Date: Thu, 25 Sep 2025 22:23:45 -0400
Message-ID: <20250926022348.1883776-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
References: <20250926022348.1883776-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

vfio_legacy_cpr_dma_map() is not only used in post_load on destination
but also error recovery path on source side. Assert it for destination
is wrong.

Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/vfio/cpr-legacy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 3ea24d60de..19fd8b60d3 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -51,8 +51,6 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainerBase *bcontainer,
         .size = size,
     };
 
-    g_assert(cpr_is_incoming());
-
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
         return -errno;
     }
-- 
2.47.1


