Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25490CA6007
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUcx-0005RN-Hu; Wed, 07 Oct 2026 12:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbY-00030W-Gm
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbU-0006O9-0y
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXB0gGMfKgb0Zt/Ycb4mBMn3jY4f23+q5GG5HrOjNfs=;
 b=JJVLha6sgXBtEBf/b1+H+FvzLsPG1BJ96lxiXGwXLvEST0GG73i9uMKJa3/DWLsUklmv8I
 bF3F5QfzLf3v49/YwlHNvEEbrMMHBrRSNC+Hnso9Ir5tgMV9p/hDTMOTtnoxS4QHGkjSBY
 Yn1nzEbRkhCJW6ifpGrond2zjNHXdgU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-VBVq-1TFOB65xpPblktjrA-1; Wed,
 07 Oct 2026 12:34:49 -0400
X-MC-Unique: VBVq-1TFOB65xpPblktjrA-1
X-Mimecast-MFC-AGG-ID: VBVq-1TFOB65xpPblktjrA_1791390888
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F5FF19775B2; Wed,  7 Oct 2026 16:34:48 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F31A61956087; Wed,  7 Oct 2026 16:34:46 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 19/21] block: reject a reopen of an unusable node instead of
 crashing
Date: Wed,  7 Oct 2026 18:33:00 +0200
Message-ID: <20261007163302.332250-20-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 block.c                    | 14 +++++++++++++-
 tests/qemu-iotests/060     | 30 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/060.out | 12 ++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index f0a6042e616..e39f15816aa 100644
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
index ccdc96b7f8b..50bdb8b81da 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -485,6 +485,36 @@ echo
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
index 27275fd6b70..7a1835221b7 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -434,4 +434,16 @@ qcow2: Image is corrupt: L2 table offset 0x2a2a2a00 unaligned (L1 index: 0); fur
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
+{"return": "Error: read failed: Input/output error\r\n"}
+{"error": {"class": "GenericError", "desc": "Block node 'drive' has no driver left to reopen"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done
-- 
2.56.0


