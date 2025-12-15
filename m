Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3D1D59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 06:52:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV2Rh-0000W8-5H; Mon, 15 Dec 2025 01:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2Ra-00007g-RG
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:52:31 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vV2RZ-0000u9-1N
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 01:52:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1765781550; x=1797317550;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hFAN9fo13oKyMqz6aFqkrlF1drPiFgR9r5J/part/VA=;
 b=B4DbgVptIflcV8N1wUf8xMK4FgXWoS0aQOzdX4WuD7xxTJRBRRJfg/C3
 Jm+MIeC9r6n5BSXLrDyk4lqwbEJr2Y3aeQHZPBP1+zW1HQVJieWdBkJqz
 sx96JVSJ8Enjt1ndPgs8dB4BjHE+QPtFfxahpMZjfTdsnERf9/heHwiaU
 wlx+7+wZn5a+ecCpAysDsqqINpbcRmxyVC7821/U50Q1lNGm+lmCG32uR
 uBagtm0llTOZZd0KkMzVAz94HDur5Om0tiDKbbaLL9uWKjm4Ax4OqWlF9
 cBkjmUfWIsrRu1b3H7sbioUmAfF7lperzX6rjnTaoUpEVW3mee7eVWdIP A==;
X-CSE-ConnectionGUID: sxBKwSpKTyGOcPOJuMQJrQ==
X-CSE-MsgGUID: jfm3Cr/rScSZzabJOpc6IQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11642"; a="71305096"
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="71305096"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:52:28 -0800
X-CSE-ConnectionGUID: cW6yZOTlTtCHmf9nDylsig==
X-CSE-MsgGUID: NCzSin3TT3Ou1/Vl9AD2Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,150,1763452800"; d="scan'208";a="197408875"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Dec 2025 22:52:23 -0800
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, peterx@redhat.com, ddutile@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v9 17/19] intel_iommu: Add migration support with x-flts=on
Date: Mon, 15 Dec 2025 01:50:41 -0500
Message-ID: <20251215065046.86991-18-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251215065046.86991-1-zhenzhong.duan@intel.com>
References: <20251215065046.86991-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15;
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
index 7e304e2988..7220a3d9f4 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4090,6 +4090,13 @@ static int vtd_post_load(void *opaque, int version_id)
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


