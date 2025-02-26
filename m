Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EABC021BB
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 01:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn5oA-0004Du-Ar; Tue, 25 Feb 2025 20:01:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tn5nm-0003t9-Ge
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 20:01:34 -0500
Received: from esa1.hc1455-7.c3s2.iphmx.com ([207.54.90.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1tn5nd-00051D-Ly
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 20:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1740531682; x=1772067682;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=jYuHGHFwJgUSZ8fd1FkvvadoSY3u79MwvRktdvNIgbY=;
 b=Dpx8gbWm8/nXwJUbsreQ5yTyt88OGY6Bok3VYXDh4L33HbATp5LvDDux
 FuAy1xbdZH0D5vtnICSfjNFCoaIyBzvhktYYTEmxXizWzQ1mg5R+pgvwY
 e+He2pm0C/fZQ3F6lLs6wFYlGJ+uREWqIKmg6NbQ9DAjLZK+e+5LPvy7k
 BSfrnpA0AOW0lSqmGJEkTrnDlNUDhtATLtvgeuZrIPGviOD22MhnZ+10S
 HrbtOlm1fg7E+4sdZLpiJn8w5B9VycFIN4UJWeZNuYmW6U8kfzuqPP4s2
 PVRIqF1MNrtlNx0BQeZ41tsJXHy5MagDk4w49r+0zFC6bPRNFBtD88lO/ A==;
X-CSE-ConnectionGUID: YWwKU41/R469v6Fz/2EACg==
X-CSE-MsgGUID: RC+s+2WxSre/I9baq1/fZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="191206654"
X-IronPort-AV: E=Sophos;i="6.13,316,1732546800"; d="scan'208";a="191206654"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2025 10:01:10 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com
 [192.168.87.58])
 by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 128B6C227C
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:01:08 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id CBF0DD8B6A
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:01:07 +0900 (JST)
Received: from iaas-rdma.. (unknown [10.167.135.44])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 3B6CD1A000B;
 Wed, 26 Feb 2025 09:01:07 +0800 (CST)
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH v3 5/6] migration: Unfold control_save_page()
Date: Wed, 26 Feb 2025 09:02:37 +0800
Message-ID: <20250226010238.727348-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250226010238.727348-1-lizhijian@fujitsu.com>
References: <20250226010238.727348-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.47; envelope-from=lizhijian@fujitsu.com;
 helo=esa1.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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


