Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A01CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:56:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu99-0004xx-7v; Tue, 12 May 2026 16:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu94-0004p3-P0; Tue, 12 May 2026 16:56:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu8z-00038j-Pn; Tue, 12 May 2026 16:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619274; bh=iS6yg6kd9P5LPm70u83D6gfXlRMV2TMAxGmVnErLYno=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SgqQbhVebyfZAYGLcOJoKOsO6wWkUSxLOh8L3CMopV4z7AXvgEiBI8pXaq4f4azPv
 Ch9zHbcw5x3ed96Rmv4yAt1JTUbo5rIxR+dZvJ5Hj/kY/EgKmk0nSc/dIjuVh0lXKh
 UsSOgIS/eJhrLOmh2OsVKIgvDpsgQk0aV+aN7WJGqv0buYQtwZTpTjZ6+KKqb1PEU/
 qBuGHa5KPWjTQEjY5YPg2HFSPu+1BQSrlvPjOG9OyWwDDfO85igFaYr50PmmyyJ7BL
 +ONwbnVE+kTRONqxzIZJhlkJIQkMX91WEOcmGqZBoR92K3hTKqkJbT9H45EOluaGhF
 wSPWy0gpB+7aw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 45DFB1AA2DA;
 Tue, 12 May 2026 23:54:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 50EE83ABC4B;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Wesley Hershberger <wesley.hershberger@canonical.com>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 014/107] block: Drop detach_subchain for
 bdrv_replace_node
Date: Tue, 12 May 2026 23:53:01 +0300
Message-ID: <20260512205437.360850-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Wesley Hershberger <wesley.hershberger@canonical.com>

Detaching filters using detach_subchain=true can cause segfaults as
described in #3149.

More specifically, this was observed when executing concurrent
block-stream and query-named-block-nodes. block-stream adds a
copy-on-read filter as the main BDS for the blockjob; that filter was
dropped with detach_subchain=true but not unref'd until the the blockjob
was free'd. Because query-named-block-nodes assumes that a filter will
always have exactly one child, it caused a segfault when it observed the
detached filter. Stacktrace:

0  bdrv_refresh_filename (bs=0x5efed72f8350)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:8082
1  0x00005efea73cf9dc in bdrv_block_device_info
    (blk=0x0, bs=0x5efed72f8350, flat=true, errp=0x7ffeb829ebd8)
    at block/qapi.c:62
2  0x00005efea7391ed3 in bdrv_named_nodes_list
    (flat=<optimized out>, errp=0x7ffeb829ebd8)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/block.c:6275
3  0x00005efea7471993 in qmp_query_named_block_nodes
    (has_flat=<optimized out>, flat=<optimized out>, errp=0x7ffeb829ebd8)
    at /usr/src/qemu-1:10.1.0+ds-5ubuntu2/b/qemu/blockdev.c:2834
4  qmp_marshal_query_named_block_nodes
    (args=<optimized out>, ret=0x7f2b753beec0, errp=0x7f2b753beec8)
    at qapi/qapi-commands-block-core.c:553
5  0x00005efea74f03a5 in do_qmp_dispatch_bh (opaque=0x7f2b753beed0)
    at qapi/qmp-dispatch.c:128
6  0x00005efea75108e6 in aio_bh_poll (ctx=0x5efed6f3f430)
    at util/async.c:219
7  0x00005efea74ffdb2 in aio_dispatch (ctx=0x5efed6f3f430)
    at util/aio-posix.c:436
8  0x00005efea7512846 in aio_ctx_dispatch (source=<optimized out>,
    callback=<optimized out>,user_data=<optimized out>)
    at util/async.c:361
9  0x00007f2b77809bfb in ?? ()
    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
10 0x00007f2b77809e70 in g_main_context_dispatch ()
    from /lib/x86_64-linux-gnu/libglib-2.0.so.0
11 0x00005efea7517228 in glib_pollfds_poll () at util/main-loop.c:287
12 os_host_main_loop_wait (timeout=0) at util/main-loop.c:310
13 main_loop_wait (nonblocking=<optimized out>) at util/main-loop.c:589
14 0x00005efea7140482 in qemu_main_loop () at system/runstate.c:905
15 0x00005efea744e4e8 in qemu_default_main (opaque=opaque@entry=0x0)
    at system/main.c:50
16 0x00005efea6e76319 in main
    (argc=<optimized out>, argv=<optimized out>)
    at system/main.c:93

As discussed in 20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com,
a filter should not exist without children in the first place; therefore,
drop the parameter entirely as it is only used for filters.

This is a partial revert of 3108a15cf09865456d499b08fe14e3dbec4ccbb3.

After this change, a blockdev-backup job's copy-before-write filter will
hold references to its children until the filter is unref'd. This causes
an additional flush during bdrv_close, so also update iotest 257.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3149
Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Wesley Hershberger <wesley.hershberger@canonical.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20251029-third-fix-3149-v2-1-94932bb404f4@canonical.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 9dbfd4e28dd11a83f54c371fade8d49a63d6dc1e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block.c b/block.c
index 0ece805e41..1c1c19d04a 100644
--- a/block.c
+++ b/block.c
@@ -5377,17 +5377,13 @@ bdrv_replace_node_noperm(BlockDriverState *from,
  *
  * With auto_skip=false the error is returned if from has a parent which should
  * not be updated.
- *
- * With @detach_subchain=true @to must be in a backing chain of @from. In this
- * case backing link of the cow-parent of @to is removed.
  */
 static int GRAPH_WRLOCK
 bdrv_replace_node_common(BlockDriverState *from, BlockDriverState *to,
-                         bool auto_skip, bool detach_subchain, Error **errp)
+                         bool auto_skip, Error **errp)
 {
     Transaction *tran = tran_new();
     g_autoptr(GSList) refresh_list = NULL;
-    BlockDriverState *to_cow_parent = NULL;
     int ret;
 
     GLOBAL_STATE_CODE();
@@ -5396,17 +5392,6 @@ bdrv_replace_node_common(BlockDriverState *from, BlockDriverState *to,
     assert(to->quiesce_counter);
     assert(bdrv_get_aio_context(from) == bdrv_get_aio_context(to));
 
-    if (detach_subchain) {
-        assert(bdrv_chain_contains(from, to));
-        assert(from != to);
-        for (to_cow_parent = from;
-             bdrv_filter_or_cow_bs(to_cow_parent) != to;
-             to_cow_parent = bdrv_filter_or_cow_bs(to_cow_parent))
-        {
-            ;
-        }
-    }
-
     /*
      * Do the replacement without permission update.
      * Replacement may influence the permissions, we should calculate new
@@ -5418,11 +5403,6 @@ bdrv_replace_node_common(BlockDriverState *from, BlockDriverState *to,
         goto out;
     }
 
-    if (detach_subchain) {
-        /* to_cow_parent is already drained because from is drained */
-        bdrv_remove_child(bdrv_filter_or_cow_child(to_cow_parent), tran);
-    }
-
     refresh_list = g_slist_prepend(refresh_list, to);
     refresh_list = g_slist_prepend(refresh_list, from);
 
@@ -5441,7 +5421,7 @@ out:
 int bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
                       Error **errp)
 {
-    return bdrv_replace_node_common(from, to, true, false, errp);
+    return bdrv_replace_node_common(from, to, true, errp);
 }
 
 int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
@@ -5457,7 +5437,7 @@ int bdrv_drop_filter(BlockDriverState *bs, Error **errp)
 
     bdrv_drained_begin(child_bs);
     bdrv_graph_wrlock();
-    ret = bdrv_replace_node_common(bs, child_bs, true, true, errp);
+    ret = bdrv_replace_node_common(bs, child_bs, true, errp);
     bdrv_graph_wrunlock();
     bdrv_drained_end(child_bs);
 
@@ -5914,17 +5894,7 @@ int bdrv_drop_intermediate(BlockDriverState *top, BlockDriverState *base,
         updated_children = g_slist_prepend(updated_children, c);
     }
 
-    /*
-     * It seems correct to pass detach_subchain=true here, but it triggers
-     * one more yet not fixed bug, when due to nested aio_poll loop we switch to
-     * another drained section, which modify the graph (for example, removing
-     * the child, which we keep in updated_children list). So, it's a TODO.
-     *
-     * Note, bug triggered if pass detach_subchain=true here and run
-     * test-bdrv-drain. test_drop_intermediate_poll() test-case will crash.
-     * That's a FIXME.
-     */
-    bdrv_replace_node_common(top, base, false, false, &local_err);
+    bdrv_replace_node_common(top, base, false, &local_err);
     bdrv_graph_wrunlock();
 
     if (local_err) {
diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
index 7d3720b8e5..cd0468aaa1 100755
--- a/tests/qemu-iotests/257
+++ b/tests/qemu-iotests/257
@@ -310,14 +310,18 @@ def test_bitmap_sync(bsync_mode, msync_mode='bitmap', failure=None):
                     'state': 1,
                     'new_state': 2
                 }, {
-                    'event': 'read_aio',
+                    'event': 'flush_to_disk',
                     'state': 2,
                     'new_state': 3
+                }, {
+                    'event': "read_aio",
+                    'state': 3,
+                    'new_state': 4
                 }],
                 'inject-error': [{
                     'event': 'read_aio',
                     'errno': 5,
-                    'state': 3,
+                    'state': 4,
                     'immediately': False,
                     'once': True
                 }]
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index c33dd7f3a9..fb28333cb2 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -272,7 +272,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -1017,7 +1017,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -1762,7 +1762,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -2507,7 +2507,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -3252,7 +3252,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -3997,7 +3997,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
@@ -4742,7 +4742,7 @@ qemu_img compare "TEST_DIR/PID-img" "TEST_DIR/PID-fbackup2" ==> Identical, OK!
 
 --- Preparing image & VM ---
 
-{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 3}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "read_aio", "new-state": 3, "state": 2}]}, "node-name": "drive0"}}
+{"execute": "blockdev-add", "arguments": {"driver": "qcow2", "file": {"driver": "blkdebug", "image": {"driver": "file", "filename": "TEST_DIR/PID-img"}, "inject-error": [{"errno": 5, "event": "read_aio", "immediately": false, "once": true, "state": 4}], "set-state": [{"event": "flush_to_disk", "new-state": 2, "state": 1}, {"event": "flush_to_disk", "new-state": 3, "state": 2}, {"event": "read_aio", "new-state": 4, "state": 3}]}, "node-name": "drive0"}}
 {"return": {}}
 
 --- Write #0 ---
-- 
2.47.3


