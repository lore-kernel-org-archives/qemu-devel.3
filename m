Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9873FCCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 08:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCDRn-00076i-Iu; Fri, 24 Oct 2025 04:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDRB-0006Xk-EO
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:46:20 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vCDR9-0006be-0q
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 04:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761295575; x=1792831575;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CgXD+k2TJvJmEmmdHJC9XfHb7C5ZiRcVGTdnpTUR8Js=;
 b=UDpwtotGjyaLu4gXugYug/nzzCxIzVdZcRmK87RbcSCNLkuP6t4NAzWJ
 HrzVfoJMRJFWnOSmO+uDAFfUcTtr5WkeaIRCPJYfQF/L5HAinqjDvfmL4
 2N23/ypADulQ9sGokr/1WLTpfxuuHQNX80IDbjPMIWags0EkpNpNXvN5N
 LZqCJ/bm50oCd2TMRFTF9hRIWFCbHlDMPKwlodRIXx6VceUZtlXH1ATqw
 FVDAYCY339oA7mBjJOE8EKnlgI/foOuegkn9gTaesp97K98nxs+GvCErC
 xKS7wvLQK43UK4OCWxYEKHdMB2ngFw87gdcQOKYZ4ox+aiCOWDSRF3UmL w==;
X-CSE-ConnectionGUID: lC1d7xC1RGaR6arnoenABQ==
X-CSE-MsgGUID: en6XTdq/SUa/pcAK5bbJTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="62504911"
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="62504911"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:59 -0700
X-CSE-ConnectionGUID: WGpqu+cuQdiylDt1ptsmdg==
X-CSE-MsgGUID: kA1YJ+naTYC+jZI/wRcumg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,252,1754982000"; d="scan'208";a="183986088"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Oct 2025 01:45:55 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com,
 jgg@nvidia.com, nicolinc@nvidia.com, skolothumtho@nvidia.com,
 joao.m.martins@oracle.com, clement.mathieu--drif@eviden.com,
 kevin.tian@intel.com, yi.l.liu@intel.com, chao.p.peng@intel.com,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 21/23] intel_iommu: Add migration support with x-flts=on
Date: Fri, 24 Oct 2025 04:43:45 -0400
Message-ID: <20251024084349.102322-22-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251024084349.102322-1-zhenzhong.duan@intel.com>
References: <20251024084349.102322-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

When x-flts=on, we set up bindings to nested HWPT in host, after
migration, VFIO device binds to nesting parent HWPT by default.
We need to re-establish the bindings to nested HWPT, or else device
DMA will break.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index edd1416382..8fec61be3e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4360,6 +4360,13 @@ static int vtd_post_load(void *opaque, int version_id)
      */
     vtd_switch_address_space_all(iommu);
 
+    /*
+     * Bindings to nested HWPT in host is set up dynamically depending
+     * on pasid entry configuration from guest. After migration, we
+     * need to re-establish the bindings before restore device's DMA.
+     */
+    vtd_replay_pasid_bindings_all(iommu);
+
     return 0;
 }
 
-- 
2.47.1


