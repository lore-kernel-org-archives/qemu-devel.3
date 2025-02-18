Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D404C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 07:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkIFU-0007BG-Do; Tue, 18 Feb 2025 02:42:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tkIFR-0007B4-UJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:42:29 -0500
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tkIFP-0005GM-Vc
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 02:42:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1739864548; x=1771400548;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=WCqnUjd5oll7mPcm5XczAQ+EKeWGdIxE1HaRweDdfFM=;
 b=EmViTFyqrtYIIi4Q7+bS2yrY0h9yLKdmgVef5MnneaI6gYiDPfPMqRvi
 pbM7Zt1a+XkaIM5bsC34AZLx6o6fyvl0UsOrUqP5fKcGv8mzjGZgQAk6T
 f7frgsrulLGgxCz9UkQUsNTr+W2uT4hYNtxxyMoMHhICMkqgsuXMazofP
 ZJjTf47fx/aP/eGVPhAWyQjtM3wGwivniofJf+ZaKOh5BRBGT333Z+7up
 gKp7p9FYBEgZ549hp0dwKRSiIR6Y4ycbTISzJVQvDDF87SJQedBm/aR5s
 CF0f3mtMMHz5iuh6e5FjqHx0leG29BmZKESvdep9oIkDiBe/zym8sp2QB Q==;
X-CSE-ConnectionGUID: /EmTYLTWRXyfgkk6MNWwWA==
X-CSE-MsgGUID: S82Ohc8hQXKNlQQNiUFo3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="190317210"
X-IronPort-AV: E=Sophos;i="6.13,295,1732546800"; d="scan'208";a="190317210"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Feb 2025 16:42:24 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 898BADBB94
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 16:42:21 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4A47BBF4B5
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 16:42:21 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 8C7B71A000B;
 Tue, 18 Feb 2025 15:42:20 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH 1/2] migration: Prioritize RDMA in ram_save_target_page()
Date: Tue, 18 Feb 2025 15:43:44 +0800
Message-ID: <20250218074345.638203-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.49; envelope-from=lizhijian@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
Reply-to:  Li Zhijian <lizhijian@fujitsu.com>
From:  Li Zhijian via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Address an error in RDMA-based migration by ensuring RDMA is prioritized
when saving pages in `ram_save_target_page()`.

Previously, the RDMA protocol's page-saving step was placed after other
protocols due to a refactoring in commit bc38dc2f5f3. This led to migration
failures characterized by unknown control messages and state loading errors
destination:
(qemu) qemu-system-x86_64: Unknown control message QEMU FILE
qemu-system-x86_64: error while loading state section id 1(ram)
qemu-system-x86_64: load of migration failed: Operation not permitted
source:
(qemu) qemu-system-x86_64: RDMA is in an error state waiting migration to abort!
qemu-system-x86_64: failed to save SaveStateEntry with id(name): 1(ram): -1
qemu-system-x86_64: rdma migration: recv polling control error!
qemu-system-x86_64: warning: Early error. Sending error.
qemu-system-x86_64: warning: rdma migration: send polling control error

RDMA migration implemented its own protocol/method to send pages to
destination side, hand over to RDMA first to prevent pages being saved by
other protocol.

Fixes: bc38dc2f5f3 ("migration: refactor ram_save_target_page functions")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/ram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 6f460fd22d2..635a2fe443a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1964,6 +1964,11 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
+    /* Hand over to RDMA first */
+    if (control_save_page(pss, offset, &res)) {
+        return res;
+    }
+
     if (!migrate_multifd()
         || migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
         if (save_zero_page(rs, pss, offset)) {
@@ -1976,10 +1981,6 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
         return ram_save_multifd_page(block, offset);
     }
 
-    if (control_save_page(pss, offset, &res)) {
-        return res;
-    }
-
     return ram_save_page(rs, pss);
 }
 
-- 
2.44.0


