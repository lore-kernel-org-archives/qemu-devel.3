Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F16CCF2D1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB5X-0005Y4-JP; Sat, 17 Oct 2026 16:33:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB3e-0003Rr-OW; Sat, 17 Oct 2026 16:31:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB3c-0004VZ-Tv; Sat, 17 Oct 2026 16:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268874; bh=M6KdwVpWdOu9X6qiFCVuIA5zPQmkk5QVPgRjN7msLP8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NK880zlbJpWkqCbUhdyrZp7nagBT9xDl764btUYhDm1FmeyMXQagMTG4noXr/wAfP
 qbsZk5qyQQEY7bpaS/mpVIOZjzl1TOyXsZOH7geQr1WhATc69h9j4rpL+E9ZZMHut0
 obqdXnuVu8vm0Mn9kXAGzboboxzwn7XVcTZlNrv8Ky3jsLJbhbMy/mPJvXIbJPLdKz
 ehttdyx6Jx4rAZh2xtnT6Iap2pQYmK2l6gZfwG4GvxH8GL3POkHbblIAjd78i4jkUr
 Ic9bk0vTL3bYzUlp0VoR0gcMwj5Yastsi1seUe0MnTyezFseS6A4duIRxaxlt9yYrS
 wrJutzsFHCX0w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0ACC71DE76C;
 Sat, 17 Oct 2026 23:27:54 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E392B443440;
 Sat, 17 Oct 2026 23:27:52 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 46/73] block: reject a reopen of an unusable node
 instead of crashing
Date: Sat, 17 Oct 2026 23:26:04 +0300
Message-ID: <20261017202638.728621-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
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

From: "Denis V. Lunev" <den@openvz.org>

qcow2_signal_corruption() drops bs->drv, so a node can lose its driver
at any time and a reopen has to expect that. Both ends of the path
assume otherwise:

  $ qemu-io -c "read 0 64k" -c "reopen -r" corrupt.qcow2
  qcow2: Marking image as corrupt: Cluster allocation offset 0x1200
  unaligned (L2 offset: 0x40000, L2 index: 0); ...
  Segmentation fault

bdrv_reopen_queue_child() dereferences bs->drv while descending into
the children the node opened itself, and bdrv_reopen_prepare() asserts
on it. commit_clean() reopens the base of a commit job back to
read-only, so a base which goes corrupt under the job arrives here too.

There is nothing to reopen for such a node, so stop descending into its
children and let bdrv_reopen_prepare() report what every caller of
bdrv_reopen() already handles. bdrv_reopen_commit() and
bdrv_reopen_abort() keep their assertion, only a prepared entry reaches
them.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20260824133729.1141990-3-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit efe98c2a0932c09ada26b8afac3606a66f561933)
(Mjt: fixup iotest output accross v11.1.0-800-g3c0c7bfeba92
 "qemu-io: propagate errors through Error API instead of printf")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block.c b/block.c
index f0a6042e61..e39f15816a 100644
--- a/block.c
+++ b/block.c
@@ -4486,6 +4486,11 @@ bdrv_reopen_queue_child(BlockReopenQueue *bs_queue, BlockDriverState *bs,
             !qdict_haskey(options, "backing.driver");
     }
 
+    /* An unusable node is rejected by bdrv_reopen_prepare(), do not descend */
+    if (!bs->drv) {
+        return bs_queue;
+    }
+
     QLIST_FOREACH(child, &bs->children, next) {
         QDict *new_child_options = NULL;
         bool child_keep_old = keep_old_opts;
@@ -4881,9 +4886,16 @@ bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
     bool drv_prepared = false;
 
     assert(reopen_state != NULL);
-    assert(reopen_state->bs->drv != NULL);
     GLOBAL_STATE_CODE();
+
     drv = reopen_state->bs->drv;
+    if (drv == NULL) {
+        GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+        error_setg(errp, "Block node '%s' has no driver left to reopen",
+                   bdrv_get_device_or_node_name(reopen_state->bs));
+        return -ENOMEDIUM;
+    }
 
     /* This function and each driver's bdrv_reopen_prepare() remove
      * entries from reopen_state->options as they are processed, so
diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 5cd21a6f68..ce49fc34ec 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -486,6 +486,36 @@ echo
 # Image should not have been marked corrupt
 _img_info --format-specific | grep 'corrupt:'
 
+echo
+echo "=== Testing the reopen of an image corrupted at runtime ==="
+echo
+
+_make_test_img 64M
+poke_file "$TEST_IMG" "$l1_offset" "\x00\x00\x00\x00\x2a\x2a\x2a\x2a"
+
+# The read leaves the node unusable, the reopen must report that
+echo "{'execute': 'qmp_capabilities'}
+      {'execute': 'human-monitor-command',
+       'arguments': {'command-line': 'qemu-io drive \"read 0 512\"'}}
+      {'execute': 'blockdev-reopen',
+       'arguments': {'options': [{'node-name': 'drive',
+                                  'driver': 'qcow2',
+                                  'read-only': true,
+                                  'file': {
+                                      'driver': 'file',
+                                      'filename': '$TEST_IMG'
+                                  }}]}}
+      {'execute': 'quit'}" \
+    | $QEMU -qmp stdio -nographic -nodefaults \
+            -blockdev "{'node-name': 'drive',
+                        'driver': 'qcow2',
+                        'file': {
+                            'driver': 'file',
+                            'filename': '$TEST_IMG'
+                        }}" \
+            2>&1 \
+    | _filter_qmp | _filter_qemu_io
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index a37bf446e9..ad1912a43b 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -436,4 +436,17 @@ qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); fur
 {"return": {}}
 
     corrupt: false
+
+=== Testing the reopen of an image corrupted at runtime ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+QMP_VERSION
+{"return": {}}
+qcow2: Marking image as corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); further corruption events will be suppressed
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "", "msg": "L2 table offset 0x2a2a2a00 unaligned (L1 index: 0)", "node-name": "drive", "fatal": true}}
+read failed: Input/output error
+{"return": ""}
+{"error": {"class": "GenericError", "desc": "Block node 'drive' has no driver left to reopen"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
-- 
2.47.3


