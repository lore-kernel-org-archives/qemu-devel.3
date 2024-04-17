Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54129C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 02:41:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwvEi-0008J9-KB; Tue, 16 Apr 2024 22:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rwvEg-0008DS-5J
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 22:41:22 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com ([139.138.61.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lizhijian@fujitsu.com>)
 id 1rwvEe-0008W9-0t
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 22:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1713321679; x=1744857679;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Qdcpx/hoDUbCpcoutgGR/idLwskBHumLPT2wQXOQAGU=;
 b=EBEny8l4agSuPBmB+SwkG+sSb8H4NnD5RRSdXzTusdogvgFROkgKDgBk
 z1RxiQfzM/rx8LtDxOxNkOAZE0OfPiBaCCvtOhZweYrAljQnFDb40Ro1I
 BvjuGl5nRpiWJiUpEIHLrzlB4+a1iaxrfSiDdBo0wyKjOpJRHbTVbWDzO
 tQAI44ba0SywOhvm78MykTVgigS5cz4EWtW5oOd+PLrV5Y19IQbLiwnOV
 cPcQk3RmqV8IM69MO8Y3L4xUz7OBUjAemy2qLMMJ2Ek74mdHvFrC6Djjv
 W5nJSz8lDtJD41knYshTZYV/eqZKE4o94nNnUm3u4dShX+SHcEKiyGt+w A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="143781331"
X-IronPort-AV: E=Sophos;i="6.07,207,1708354800"; d="scan'208";a="143781331"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
 by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Apr 2024 11:41:13 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com
 [192.168.83.65])
 by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id EEB522A1C0F
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:41:11 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 216BF3D6F2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:41:11 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 89BCC201F9530
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:41:10 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 589AE1A0002;
 Wed, 17 Apr 2024 10:41:09 +0800 (CST)
To: zhanghailiang@xfusion.com,
	peterx@redhat.com,
	farosas@suse.de
Cc: qemu-devel@nongnu.org, chen.zhang@intel.com,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>
Subject: [PATCH] migration/colo: Fix bdrv_graph_rdlock_main_loop: Assertion
 `!qemu_in_coroutine()' failed.
Date: Wed, 17 Apr 2024 10:44:22 +0800
Message-Id: <20240417024422.1014358-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28326.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28326.004
X-TMASE-Result: 10-2.135800-10.000000
X-TMASE-MatchedRID: 90G6ca/P0SOPo+6vQMop+lcgCgDL49aa8nuBtG35YKtZUipC+zHNiopb
 wG9fIuITrn7hLrBOoti89piuHlsL5yXgtXpCvamunVTWWiNp+v/kwFzTzcgzhN8pqleQItEFKpi
 9XFTnNcAi+t+0AiFaYmjNFjPo9uuVEuM/sJgx7r/OvXpg7ONnXXqzvrpgMDQqd6kz8j616pyjxY
 yRBa/qJcFwgTvxipFajoczmuoPCq007ASxMGXRotlw5xoEYh1rzqmdqHXT9gqiCj3+7h4OrnsgF
 O6s6k41Qxrc0X6KVYHSvUkqFdFuHVoWWzZaAEBzCyHla9remT4Vwbf5lERMgI/2RRfVn5u4Tcu6
 aRtCI3BUKpNI+7y1VHsDEgQ63iHZ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Received-SPF: pass client-ip=139.138.61.253;
 envelope-from=lizhijian@fujitsu.com; helo=esa8.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

bdrv_activate_all() should not be called from the coroutine context, move
it to the QEMU thread colo_process_incoming_thread() with the bql_lock
protected.

The backtrace is as follows:
 #4  0x0000561af7948362 in bdrv_graph_rdlock_main_loop () at ../block/graph-lock.c:260
 #5  0x0000561af7907a68 in graph_lockable_auto_lock_mainloop (x=0x7fd29810be7b) at /patch/to/qemu/include/block/graph-lock.h:259
 #6  0x0000561af79167d1 in bdrv_activate_all (errp=0x7fd29810bed0) at ../block.c:6906
 #7  0x0000561af762b4af in colo_incoming_co () at ../migration/colo.c:935
 #8  0x0000561af7607e57 in process_incoming_migration_co (opaque=0x0) at ../migration/migration.c:793
 #9  0x0000561af7adbeeb in coroutine_trampoline (i0=-106876144, i1=22042) at ../util/coroutine-ucontext.c:175
 #10 0x00007fd2a5cf21c0 in  () at /lib64/libc.so.6

CC: Fabiano Rosas <farosas@suse.de>
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2277
Fixes: 2b3912f135 ("block: Mark bdrv_first_blk() and bdrv_is_root_node() GRAPH_RDLOCK")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 migration/colo.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 84632a603e..94942fba32 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -835,6 +835,15 @@ static void *colo_process_incoming_thread(void *opaque)
         return NULL;
     }
 
+    /* Make sure all file formats throw away their mutable metadata */
+    bql_lock();
+    bdrv_activate_all(&local_err);
+    if (local_err) {
+        error_report_err(local_err);
+        return NULL;
+    }
+    bql_unlock();
+
     failover_init_state();
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
@@ -922,7 +931,6 @@ out:
 int coroutine_fn colo_incoming_co(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-    Error *local_err = NULL;
     QemuThread th;
 
     assert(bql_locked());
@@ -931,13 +939,6 @@ int coroutine_fn colo_incoming_co(void)
         return 0;
     }
 
-    /* Make sure all file formats throw away their mutable metadata */
-    bdrv_activate_all(&local_err);
-    if (local_err) {
-        error_report_err(local_err);
-        return -EINVAL;
-    }
-
     qemu_thread_create(&th, "COLO incoming", colo_process_incoming_thread,
                        mis, QEMU_THREAD_JOINABLE);
 
-- 
2.31.1


