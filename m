Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B61DC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GPX-0003eI-On; Tue, 07 May 2024 04:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPO-0003TJ-Kf; Tue, 07 May 2024 04:42:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GPL-0003Dh-Jf; Tue, 07 May 2024 04:42:45 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD3E464BC8;
 Tue,  7 May 2024 11:42:48 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AA06EC85B1;
 Tue,  7 May 2024 11:42:29 +0300 (MSK)
Received: (nullmailer pid 1026524 invoked by uid 1000);
 Tue, 07 May 2024 08:42:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Li Zhijian <lizhijian@fujitsu.com>,
 Fabiano Rosas <farosas@suse.de>, Zhang Chen <chen.zhang@intel.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.4 04/16] migration/colo: Fix bdrv_graph_rdlock_main_loop:
 Assertion `!qemu_in_coroutine()' failed.
Date: Tue,  7 May 2024 11:42:03 +0300
Message-Id: <20240507084226.1026455-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
References: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Li Zhijian <lizhijian@fujitsu.com>

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

Cc: qemu-stable@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>
Closes: https://gitlab.com/qemu-project/qemu/-/issues/2277
Fixes: 2b3912f135 ("block: Mark bdrv_first_blk() and bdrv_is_root_node() GRAPH_RDLOCK")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Reviewed-by: Zhang Chen <chen.zhang@intel.com>
Tested-by: Zhang Chen <chen.zhang@intel.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240417025634.1014582-1-lizhijian@fujitsu.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 2cc637f1ea08d2a1b19fc5b1a30bc609f948de93)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
(Mjt: fixup bql_lock() => qemu_mutex_lock_iothread() for v8.2.0-444-g195801d700c0
 "system/cpus: rename qemu_mutex_lock_iothread() to bql_lock()")

diff --git a/migration/colo.c b/migration/colo.c
index 4447e34914..8f301b7e57 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -830,6 +830,16 @@ static void *colo_process_incoming_thread(void *opaque)
         return NULL;
     }
 
+    /* Make sure all file formats throw away their mutable metadata */
+    qemu_mutex_lock_iothread();
+    bdrv_activate_all(&local_err);
+    if (local_err) {
+        qemu_mutex_unlock_iothread();
+        error_report_err(local_err);
+        return NULL;
+    }
+    qemu_mutex_unlock_iothread();
+
     failover_init_state();
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
@@ -917,7 +927,6 @@ out:
 int coroutine_fn colo_incoming_co(void)
 {
     MigrationIncomingState *mis = migration_incoming_get_current();
-    Error *local_err = NULL;
     QemuThread th;
 
     assert(qemu_mutex_iothread_locked());
@@ -926,13 +935,6 @@ int coroutine_fn colo_incoming_co(void)
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
2.39.2


