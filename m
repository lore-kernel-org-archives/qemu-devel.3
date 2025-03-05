Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB0AC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiDq-0002Gn-UN; Wed, 05 Mar 2025 01:27:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDe-0002EM-Gl
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:04 -0500
Received: from esa7.hc1455-7.c3s2.iphmx.com ([139.138.61.252])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tpiDb-0007fR-N4
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 01:27:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1741156019; x=1772692019;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=aGMfL9Y4ZguUCaGuBijWVIIjX8bazUzbs1q0hk1VKy0=;
 b=Guz6iE6DB4IhMHRGuSFs/YBlA/ekXW0TdsfczKg5WyqYSgzk3yF2pJS9
 C03/pUsgYLeXkZlTCUO/xM2DoEHVZIKBWKnX4KK6Tt18FPpQoYnGnByEh
 ZU4uSxucTZW3jZL27OGnIOW06jqe9/kYvWSReMcEr7aERZPr5bCw9W9Gv
 VtgvBiAVh0+yhdA02n3CunFffi9fzNFzf/fnIcZ72CYlQWjBwomQytaR+
 /iRLr5kSEyssWj98x1xQp0GUtDWrrmkr3qK7Ng/0Q5BSNfM6aiSLdj653
 dg33jaOamxWeYVSibLBnc2HrN+AzTc8bfryBxXgK7MGiSaAa3q5gr/zzp w==;
X-CSE-ConnectionGUID: CBN4qQoRSs+DdSw46W+70g==
X-CSE-MsgGUID: hR0ih6rYR/WBeP+taP9PlA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="170889611"
X-IronPort-AV: E=Sophos;i="6.14,222,1736780400"; d="scan'208";a="170889611"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Mar 2025 15:26:55 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 6F0B3C2264
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:53 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 364D3D5B4E
 for <qemu-devel@nongnu.org>; Wed,  5 Mar 2025 15:26:53 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 89C551A00A1;
 Wed,  5 Mar 2025 14:26:52 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v5 5/6] migration: Unfold control_save_page()
Date: Wed,  5 Mar 2025 14:28:24 +0800
Message-ID: <20250305062825.772629-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250305062825.772629-1-lizhijian@fujitsu.com>
References: <20250305062825.772629-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=139.138.61.252;
 envelope-from=lizhijian@fujitsu.com; helo=esa7.hc1455-7.c3s2.iphmx.com
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

control_save_page() is for RDMA only, unfold it to make the code more
clear.
In addition:
 - Similar to other branches style in ram_save_target_page(), involve RDMA
   only if the condition 'migrate_rdma()' is true.
 - Further simplify the code by removing the RAM_SAVE_CONTROL_NOT_SUPP.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3:
  squash previous 2nd, 3th, 4th into one patch
---
 migration/ram.c  | 34 +++++++---------------------------
 migration/rdma.c |  7 ++-----
 migration/rdma.h |  3 +--
 3 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 424df6d9f13..c363034c882 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1143,32 +1143,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
     return len;
 }
 
-/*
- * @pages: the number of pages written by the control path,
- *        < 0 - error
- *        > 0 - number of pages written
- *
- * Return true if the pages has been saved, otherwise false is returned.
- */
-static bool control_save_page(PageSearchStatus *pss,
-                              ram_addr_t offset, int *pages)
-{
-    int ret;
-
-    ret = rdma_control_save_page(pss->pss_channel, pss->block->offset, offset,
-                                 TARGET_PAGE_SIZE);
-    if (ret == RAM_SAVE_CONTROL_NOT_SUPP) {
-        return false;
-    }
-
-    if (ret == RAM_SAVE_CONTROL_DELAYED) {
-        *pages = 1;
-        return true;
-    }
-    *pages = ret;
-    return true;
-}
-
 /*
  * directly send the page to the stream
  *
@@ -1965,7 +1939,13 @@ static int ram_save_target_page(RAMState *rs, PageSearchStatus *pss)
     int res;
 
     /* Hand over to RDMA first */
-    if (control_save_page(pss, offset, &res)) {
+    if (migrate_rdma()) {
+        res = rdma_control_save_page(pss->pss_channel, pss->block->offset,
+                                     offset, TARGET_PAGE_SIZE);
+
+        if (res == RAM_SAVE_CONTROL_DELAYED) {
+            res = 1;
+        }
         return res;
     }
 
diff --git a/migration/rdma.c b/migration/rdma.c
index e5b4ac599b1..08eb924ffaa 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3284,14 +3284,11 @@ err:
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    if (!migrate_rdma()) {
-        return RAM_SAVE_CONTROL_NOT_SUPP;
-    }
+    assert(migrate_rdma());
 
     int ret = qemu_rdma_save_page(f, block_offset, offset, size);
 
-    if (ret != RAM_SAVE_CONTROL_DELAYED &&
-        ret != RAM_SAVE_CONTROL_NOT_SUPP) {
+    if (ret != RAM_SAVE_CONTROL_DELAYED) {
         if (ret < 0) {
             qemu_file_set_error(f, ret);
         }
diff --git a/migration/rdma.h b/migration/rdma.h
index f55f28bbed1..8eeb0117b91 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -33,7 +33,6 @@ void rdma_start_incoming_migration(InetSocketAddress *host_port, Error **errp);
 #define RAM_CONTROL_ROUND     1
 #define RAM_CONTROL_FINISH    3
 
-#define RAM_SAVE_CONTROL_NOT_SUPP -1000
 #define RAM_SAVE_CONTROL_DELAYED  -2000
 
 #ifdef CONFIG_RDMA
@@ -56,7 +55,7 @@ static inline
 int rdma_control_save_page(QEMUFile *f, ram_addr_t block_offset,
                            ram_addr_t offset, size_t size)
 {
-    return RAM_SAVE_CONTROL_NOT_SUPP;
+    g_assert_not_reached();
 }
 #endif
 #endif
-- 
2.44.0


