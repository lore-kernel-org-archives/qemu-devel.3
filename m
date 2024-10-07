Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020B4CFB455
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:18:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxtFD-0005an-0d; Mon, 07 Oct 2024 15:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtF9-0005X6-TY; Mon, 07 Oct 2024 15:18:08 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sxtF7-0004CP-PK; Mon, 07 Oct 2024 15:18:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 273D29624E;
 Mon,  7 Oct 2024 22:16:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 018F714F72E;
 Mon,  7 Oct 2024 22:16:56 +0300 (MSK)
Received: (nullmailer pid 2592752 invoked by uid 1000);
 Mon, 07 Oct 2024 19:16:54 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.1.1 17/32] migration/multifd: Fix rb->receivedmap cleanup
 race
Date: Mon,  7 Oct 2024 22:16:34 +0300
Message-Id: <20241007191654.2592616-17-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
References: <qemu-stable-9.1.1-20241007221311@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Fix a segmentation fault in multifd when rb->receivedmap is cleared
too early.

After commit 5ef7e26bdb ("migration/multifd: solve zero page causing
multiple page faults"), multifd started using the rb->receivedmap
bitmap, which belongs to ram.c and is initialized and *freed* from the
ram SaveVMHandlers.

Multifd threads are live until migration_incoming_state_destroy(),
which is called after qemu_loadvm_state_cleanup(), leading to a crash
when accessing rb->receivedmap.

process_incoming_migration_co()        ...
  qemu_loadvm_state()                  multifd_nocomp_recv()
    qemu_loadvm_state_cleanup()          ramblock_recv_bitmap_set_offset()
      rb->receivedmap = NULL               set_bit_atomic(..., rb->receivedmap)
  ...
  migration_incoming_state_destroy()
    multifd_recv_cleanup()
      multifd_recv_terminate_threads(NULL)

Move the loadvm cleanup into migration_incoming_state_destroy(), after
multifd_recv_cleanup() to ensure multifd threads have already exited
when rb->receivedmap is cleared.

Adjust the postcopy listen thread comment to indicate that we still
want to skip the cpu synchronization.

CC: qemu-stable@nongnu.org
Fixes: 5ef7e26bdb ("migration/multifd: solve zero page causing multiple page faults")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240917185802.15619-3-farosas@suse.de
[peterx: added comment in migration_incoming_state_destroy()]
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 4ce56229087860805877075ddb29dd44578365a9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/migration.c b/migration/migration.c
index 3dea06d577..ae2be31557 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -378,6 +378,11 @@ void migration_incoming_state_destroy(void)
     struct MigrationIncomingState *mis = migration_incoming_get_current();
 
     multifd_recv_cleanup();
+    /*
+     * RAM state cleanup needs to happen after multifd cleanup, because
+     * multifd threads can use some of its states (receivedmap).
+     */
+    qemu_loadvm_state_cleanup();
 
     if (mis->to_src_file) {
         /* Tell source that we are done */
diff --git a/migration/savevm.c b/migration/savevm.c
index 6bb404b9c8..b71eba218f 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2983,7 +2983,10 @@ int qemu_loadvm_state(QEMUFile *f)
     trace_qemu_loadvm_state_post_main(ret);
 
     if (mis->have_listen_thread) {
-        /* Listen thread still going, can't clean up yet */
+        /*
+         * Postcopy listen thread still going, don't synchronize the
+         * cpus yet.
+         */
         return ret;
     }
 
@@ -3026,7 +3029,6 @@ int qemu_loadvm_state(QEMUFile *f)
         }
     }
 
-    qemu_loadvm_state_cleanup();
     cpu_synchronize_all_post_init();
 
     return ret;
-- 
2.39.5


