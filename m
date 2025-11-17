Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5860DCEBF96
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 09:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKvj7-0006Ef-Sz; Mon, 17 Nov 2025 04:40:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKviI-0005BL-Ty
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:40:06 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vKviF-0006HR-VN
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 04:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763372396; x=1794908396;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=F/UlVir0CPbKiBxFTUK1dLBiSRa0vktrD+oJw9HyZT0=;
 b=g/3eNsBO2igncWG9UL76BCw5diQfEzTJlBCGfVXn8zeGDss2he/2iIFA
 4LEYR/W1Ljwaan0yHX6LBsdvDO2JiFeaude1SZjXaT+k+8esEbcj3aphA
 akVt7LnQs46Pa/RxqBJiv3qVIyJ/VYG53MUi3voqWsLPeZ/35W09QlHBA
 XgMKZuKNzR4Alb4AQBCPy9OAn8aZMm3BrT7A/GbIsKZ44ls4SXqibj5mH
 WlUr+GwvaIbxyQwM1VbMLNZWOwfCRvTDJaZ+Q9U2whs1fyeQo6eMgkDfj
 KRuZf14DnBmOLwQi2YXsvJHCqpbwo3AUD9LsAMr06muD5mnthOJZb+vz7 A==;
X-CSE-ConnectionGUID: YxRGx4xiQ2S5SdpG+MD9jg==
X-CSE-MsgGUID: nBTHY5xDQn64jwBkBv9nfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11615"; a="76046064"
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="76046064"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:44 -0800
X-CSE-ConnectionGUID: t/DiLwDIRNW/fW4ZYlBRgA==
X-CSE-MsgGUID: pWgY1I2bRCeseY8sgrwcQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,311,1754982000"; d="scan'208";a="190070978"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2025 01:39:40 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v8 18/23] intel_iommu: Add migration support with x-flts=on
Date: Mon, 17 Nov 2025 04:37:21 -0500
Message-ID: <20251117093729.1121324-19-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
References: <20251117093729.1121324-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.9;
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

When x-flts=on, we set up bindings to nested HWPT in host, after
migration, VFIO device binds to nesting parent HWPT by default.
We need to re-establish the bindings to nested HWPT, or else device
DMA will break.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 hw/i386/intel_iommu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 42c1bf48f1..269b7da958 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4091,6 +4091,13 @@ static int vtd_post_load(void *opaque, int version_id)
      */
     vtd_switch_address_space_all(iommu);
 
+    /*
+     * Bindings to nested HWPT in host is set up dynamically depending
+     * on pasid entry configuration from guest. After migration, we
+     * need to re-establish the bindings before restoring device's DMA.
+     */
+    vtd_replay_pasid_bindings_all(iommu);
+
     return 0;
 }
 
-- 
2.47.1


