Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56BA1C282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiDs-0002H3-Uo; Wed, 05 Mar 2025 01:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDe-0002EL-El
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:04 -0500
Received: from esa5.hc1455-7.c3s2.iphmx.com ([68.232.139.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDb-0007eh-N5
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1741156019; x=1772692019;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+CR7mMv1ubPow4V3VojBzeRtfH/4mt0zSZmZJSzhgAQ=;
 b=V049X8BJBb6iHNJvSYQKzmbOTq8gHg7l2BbH1AEnW4qVbWAuxkimUW6D
 2n+PKp9gGsekCDFexuXNXrEyBnjxFnWE87d1U9+sIA35rKC48/WX2fCax
 z5yaS+otqwQI+CVOA9IXsQUUU92rcx2vKhTkaOi+HNZ+Uzv/EGbY2DQWq
 8lmqX1/OuTQ6BJP2T+nPk6zKmoljc6LZzOtkSelNGdQr9pSEREZC5FT4+
 OVrQ9/y33Jo9P0imQYF4lQrKmz9QOI6FApQN7h8lThVn5NZfMDXKgBiUR
 tp40Q9aXi1DlLerB6xjajODiWPwOfk8CP/kjEfcGCguyn6u6vhc2v7j6I Q==;
X-CSE-ConnectionGUID: pxRF47CDRP2/aB3/eLHP6g==
X-CSE-MsgGUID: M929AnRWSoGi3ingVL2n5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="191183347"
X-IronPort-AV: E=Sophos;i="6.14,222,1736780400"; d="scan'208";a="191183347"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
 by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 15:26:53 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9CE0AE076B
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:51 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 4F286D5037
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:51 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 9BDD11A00AE;
 Wed,  5 Mar 2025 14:26:50 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v5 1/6] migration: Prioritize RDMA in ram_save_target_page()
Date: Wed,  5 Mar 2025 14:28:20 +0800
Message-ID: <20250305062825.772629-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250305062825.772629-1-lizhijian@fujitsu.com>
References: <20250305062825.772629-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=68.232.139.130;
 envelope-from=lizhijian@fujitsu.com; helo=esa5.hc1455-7.c3s2.iphmx.com
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
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
   collect Reviewed tags
---
 migration/ram.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 589b6505eb2..424df6d9f13 100644
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


