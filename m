Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DAD106F30E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5glk-0003fA-G5; Thu, 26 Mar 2026 05:12:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glj-0003W2-3U
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:47 -0400
Received: from mgamail.intel.com ([198.175.65.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w5glg-0003yp-OU
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 05:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774516365; x=1806052365;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aGJK2wSMFZuOKwveaXf6WW008jl1ihA7PpDj0CqHzKM=;
 b=HbuBwJF6PXMTC2U91bSF7OGpUHxbxJ4twsb8VyQ0MlDX8Aqb/6RoSQuB
 6KGZ+rYz8RpwDuF4OsDc5I/dL9ASbsGYr4ll0/jCC+ivF3LMubJs2EEPx
 khdqsMqK9RcIryyLXmgYc3qa/2ca0zHf3qTYM+YLnpg0v7CfSHJK3P5n9
 cKeyGc5aBin4cxniREQ/lSL0tiy/LNmHm3n9TAkh0s0os1Rbazty0c1e8
 J29lUvus1zqraH+u4omJHuMWwloBzgtWv7X1O94d9emrU8BfqUWMbLJ2T
 pgMsQd9idXs7krTEKxUJX80FFSQf1KO4qhB1p4C9tORmV8tpckDYRwZ93 w==;
X-CSE-ConnectionGUID: 1CGtKgfqQE6h9JlAbOyIKw==
X-CSE-MsgGUID: yIEb6uwJQN+FVyb7ni8Ckg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75531408"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="75531408"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:34 -0700
X-CSE-ConnectionGUID: 7kVtzEHiTsyIv7OjZrBRxg==
X-CSE-MsgGUID: BioJJa6NRfyZFzKKhyGZng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; d="scan'208";a="248368616"
Received: from unknown (HELO gnr-sp-2s-612.sh.intel.com) ([10.112.230.229])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 02:12:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex@shazbot.org, clg@redhat.com, eric.auger@redhat.com, mst@redhat.com,
 jasowang@redhat.com, jgg@nvidia.com, nicolinc@nvidia.com,
 skolothumtho@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@bull.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 xudong.hao@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v2 14/14] intel_iommu: Expose flag VIOMMU_FLAG_PASID_SUPPORTED
 when configured
Date: Thu, 26 Mar 2026 05:11:28 -0400
Message-ID: <20260326091130.321483-15-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260326091130.321483-1-zhenzhong.duan@intel.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.17;
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

VFIO device will check flag VIOMMU_FLAG_PASID_SUPPORTED and expose PASID
capability, or else guest could not enable PASID of this device even if
vIOMMU's pasid is configured.

This is the final knob to enable PASID.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
---
 hw/i386/intel_iommu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 5d0184fa0d..96b4102ab9 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4795,6 +4795,7 @@ static uint64_t vtd_get_viommu_flags(void *opaque)
     uint64_t flags;
 
     flags = s->fsts ? VIOMMU_FLAG_WANT_NESTING_PARENT : 0;
+    flags |= s->pasid ? VIOMMU_FLAG_PASID_SUPPORTED : 0;
 
     return flags;
 }
-- 
2.47.3


