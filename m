Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8367BC25B75
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H34-0000O5-Ax; Tue, 07 May 2024 05:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2l-0000IS-Vr
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:29 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1s4H2k-00008K-AZ
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1715073806; x=1746609806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OP3qnqR2eeb5LkENXO26BG3fJHDhCXlpbz0ddpelol0=;
 b=jr91kzGn2n/qC0s1tFjjVxlKClUxMVUEnR6KnS1WAQG9J7Au2JYQQ+n8
 TGMKIXPnqaKTT7+vI3kzdJZWNFDjtmc0O3Ps1Eb5dp5kDYByoeuFFawJ0
 ptv6zW+9/Bc9S86Nfp/Dkopr7gDj02i4b8hx8WDFDR0YIyc18E3b0wwQe
 xaU0eSnsklCDV8Aw6OSWWF63TqFqjKXQKslZYW/NvySu1WymT5IR/J+aY
 sBOBcorKMMR/DznAzPJFYqtdHYHZDS65tnyyRwX6/K5VscqheF7YeTTdq
 MZ0CIANY4oOEWIwt1WK3pq1bKm9dbR++oA8X1SNc51DBWsVF05ZEHM18o Q==;
X-CSE-ConnectionGUID: Qm554SzNS46sMfycpaiw8w==
X-CSE-MsgGUID: yrz/9y78S6iOredMgg8E1w==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10785219"
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="10785219"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:25 -0700
X-CSE-ConnectionGUID: NLG9r/BsQmm9VtKU9skemQ==
X-CSE-MsgGUID: lxb+YFgjRr6N/WqDsBs3VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,260,1708416000"; d="scan'208";a="28553292"
Received: from unknown (HELO SPR-S2600BT.bj.intel.com) ([10.240.192.124])
 by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2024 02:23:22 -0700
From: Zhenzhong Duan <zhenzhong.duan@intel.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, eric.auger@redhat.com,
 mst@redhat.com, peterx@redhat.com, jasowang@redhat.com, jgg@nvidia.com,
 nicolinc@nvidia.com, joao.m.martins@oracle.com,
 clement.mathieu--drif@eviden.com, kevin.tian@intel.com, yi.l.liu@intel.com,
 chao.p.peng@intel.com, Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH v4 06/19] range: Introduce range_get_last_bit()
Date: Tue,  7 May 2024 17:20:30 +0800
Message-Id: <20240507092043.1172717-7-zhenzhong.duan@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
References: <20240507092043.1172717-1-zhenzhong.duan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

This helper get the highest 1 bit position of the upper bound.

If the range is empty or upper bound is zero, -1 is returned.

Suggested-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
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


