Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07645C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 08:34:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEm5Y-0001Gk-KN; Wed, 05 Jun 2024 04:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5W-0001GD-Qm
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:42 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sEm5V-00062T-8J
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 04:33:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1717576422; x=1749112422;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=CjSnZQ7ngmOLQ7CAWB0Crj5gNLpXxdfxGz2EE85FrHg=;
 b=mNuwpUqVmg1emXoo7DRrSiQTRFqEI6i5aXA4fpzdGv5pUhDWWAlrYxW4
 JidzxurBqJRebgHnlqVOCKeDAshKtu0CwPtSgfZxwZk/LxBV1F8fr8RWX
 pptTxCCVF3OxbYtn5DRIUZUh/BH922+HIdg9wWcMyAEUIhVs48SGz0igt
 oJmkkIzXA7E4dHvX/BM9NFNDf+xRRmfFPZopQiWzlJJJI5b8hr6hBJZiG
 wBFUqhqG35Bbs2nzO+y9o3rnbJZuOfhPeyVA4QUx1XKQJh/jSXYSOXyH5
 NczF50z+08BGIy85+BmX0f89kKOCoNoZwt9xuXgtUcTXSdN29eGib6Lyj A==;
X-CSE-ConnectionGUID: zEfumLFURvKxrzwi+OCKmw==
X-CSE-MsgGUID: Keo9WhRfQ1eUwWh5UgJiAQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11093"; a="25575334"
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="25575334"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:34 -0700
X-CSE-ConnectionGUID: m68oEKcBTG2r+fGDJn26fw==
X-CSE-MsgGUID: Z4G/BeEXRoGSdw7iImrrKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,216,1712646000"; d="scan'208";a="37954782"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.127])
 by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2024 01:33:30 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v7 05/17] range: Introduce range_get_last_bit()
Date: Wed,  5 Jun 2024 16:30:31 +0800
Message-Id: <20240605083043.317831-6-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605083043.317831-1-zhenzhong.duan@intel.com>
References: <20240605083043.317831-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This helper get the highest 1 bit position of the upper bound.

If the range is empty or upper bound is zero, -1 is returned.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
---
 include/qemu/range.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/qemu/range.h b/include/qemu/range.h
index 205e1da76d..4ce694a398 100644
--- a/include/qemu/range.h
+++ b/include/qemu/range.h
@@ -20,6 +20,8 @@
 #ifndef QEMU_RANGE_H
 #define QEMU_RANGE_H
 
+#include "qemu/bitops.h"
+
 /*
  * Operations on 64 bit address ranges.
  * Notes:
@@ -217,6 +219,15 @@ static inline int ranges_overlap(uint64_t first1, uint64_t len1,
     return !(last2 < first1 || last1 < first2);
 }
 
+/* Get highest non-zero bit position of a range */
+static inline int range_get_last_bit(Range *range)
+{
+    if (range_is_empty(range)) {
+        return -1;
+    }
+    return 63 - clz64(range->upb);
+}
+
 /*
  * Return -1 if @a < @b, 1 @a > @b, and 0 if they touch or overlap.
  * Both @a and @b must not be empty.
-- 
2.34.1


