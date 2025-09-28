Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622EBCAC5B5
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Sep 2025 08:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2nC2-0006Ri-90; Sun, 28 Sep 2025 04:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nC0-0006RJ-ST
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:40 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v2nBm-00045O-Lh
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 04:55:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759049727; x=1790585727;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1bPMtFRL3YYOPfBbPcLgkc9GDo/yeMUTGUUDeY1Ngok=;
 b=aXyPVoPNPKjlIZYcTwa6njqorEAuOe6wgvtEzwEbJAFXYyCq98F1Mdun
 QrevVI2gxxVCaneO3EANIockvDwt32Dpb/xurr0j+mmKCfmRWVukdCW8a
 kwmXN8iPeVZIG1FIDb73bPvlUTTj5Ck7t4UgV08tBJvd5Ngbt1a1bJ2RI
 Szu+WnDow6Ez2OLON7VU1fzO31fVkxXKVGGevcd5TCNnIB74YAYhB8BL6
 CgMHBsqk/eRyqPy18SUKS/UgS4Ljqf8ZUbrBvtNLPIZQ+xx6O08YAlui9
 ujGXNT7Au6wGIBS3K886dx1+oibJO2F+hSBPNvE5bx20nyd4a4Y28sMV6 Q==;
X-CSE-ConnectionGUID: Ylmka4j1SAiAaScEaFSKWw==
X-CSE-MsgGUID: ZCITI5h1Q+eHOLf2gqQc0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11566"; a="65167433"
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="65167433"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:20 -0700
X-CSE-ConnectionGUID: OrNMCXMPTI26irWx+yq3tw==
X-CSE-MsgGUID: 0IgDBlKrQ4GEUo0JJUbxEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,299,1751266800"; d="scan'208";a="177810804"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2025 01:55:19 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 steven.sistare@oracle.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 2/6] vfio/cpr-legacy: drop an erroneous assert
Date: Sun, 28 Sep 2025 04:54:28 -0400
Message-ID: <20250928085432.40107-3-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250928085432.40107-1-zhenzhong.duan@intel.com>
References: <20250928085432.40107-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

vfio_legacy_cpr_dma_map() is not only used in post_load on destination
but also error recovery path on source side. Assert it for destination
is wrong.

Fixes: 7e9f21411302 ("vfio/container: restore DMA vaddr")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/vfio/cpr-legacy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 9a37e8c604..c2b81f4a4b 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -52,8 +52,6 @@ static int vfio_legacy_cpr_dma_map(const VFIOContainer *bcontainer,
         .size = size,
     };
 
-    g_assert(cpr_is_incoming());
-
     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map)) {
         return -errno;
     }
-- 
2.47.1


