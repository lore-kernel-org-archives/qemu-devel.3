Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11052C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyUrx-0003tr-Vx; Mon, 24 Aug 2026 09:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrv-0003rP-TM
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:43 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wyUrs-0002cC-5M
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 09:37:43 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so394279566b.1
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 06:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787578659; x=1788183459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s9XFnRBTPgsRdQGCK5DBH78jDcPvK2A0wh6KqOPVhV8=;
 b=UTCdIlnmOfbnsGxSLZUf4GeO+C4jxN5hsRDcefQtY89+c5jxxH+0nBZKbppKHf7K5v
 DMP+suIqstvXgbRnDjVMFxAUnk8e+YfXqnNK2jkwbRl/NJx78au3M9AOQVwIqvLqJ299
 OhbSiqnb18T6xZ4TCzi8fEOWQ5cIpUWZrdCCqq5BWT9eqT7lT+pD5fFw/QRgWBGBDmHk
 r1+erbVHTOSdE/peCefiwgMGMS6YswIiRQhpSxItE8vq9BdNPLYGZF3DYF/XLRTdhqH8
 XPJZQqxsOoAQxz4KhXkaT7H7N67IHzo81yr60aljK2KTI1UbzbfUDg1bwjWtHfRDgEOf
 7dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787578659; x=1788183459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=s9XFnRBTPgsRdQGCK5DBH78jDcPvK2A0wh6KqOPVhV8=;
 b=TNiH4RNjm2G2ePZhDoI8P0WJT9s7v085mo1Nz3aR7M3+uWY7m6Kvu5ekbncQ7oWFZx
 8aXo5I7FRAaPb7DrOqz8ZhhSpYS9IEKxbJN8/PmZvHHtbUq0iOm22/sgWEATPnUNdLZ4
 AAjiuoK4rO80h3oAxUGWYgGZu/9o5jt10XWnBhB5r2lx1Oa1CJ2juRFyxr7GytkxMJ0c
 /fbdBycePFJNltUo5zmmd3ZPV7nItdiyvK24AQgZNn9hFq+HpOIaaDaL25lSeAyRElVD
 3MGlM9paYb8+/58Gpnt5g+HzF2qsVzA8AFgxwtnegxv0AM87Q5PFbSsWEsRpVHozzHVb
 ED5Q==
X-Gm-Message-State: AFuF++kX2aOMsB33xR8tRlU19uVt8mvZ6BDjdVVgDtqrn8Lqn6gUQpy1
 NG08GvN7a5/qs+7WwSW5ymxuTTrJaQosdMJl15Up1WgH3vkNxoVivP+avMn/pepalU2c2dah9hT
 ME4GH
X-Gm-Gg: AR+sD12rhal/wJhf5wpMIU7brNzVSObgHXOvlDIj0YRojYLm+HdEj/iRdYDsp2cWHlc
 PNxgryDr7rhFCeu4+0FF2aOA+gAattFXZl0KLcSjak2RarEHJHiZCs0P4MGKpXmxsiqXwv+1OAB
 UjxUeIyfySc2x+TloNt5/rCwMdFpeFM5cH79oEIAhWYsA0wy7sZB/2YdbJ2OFwWB2JRiTvpoNw1
 AjliZ7rl9JK4Bvdx2iyrtdP2UUZYP/5QR6O1txM4xwzZXbKSJTkonbrmy6rqzcX+cyvAZ8p5OKW
 yiQj1fnyNtNyDN0nxe9eK09prMxo9vVMkGFk2jmEN8aCzQsHB1vkv9GzGWlMEcEksLdA/i/iq7W
 Xl+Q3y4R2twzCM/HbweBGM1b1IPK4WyCFWsaVG1ORww1NF8FHrAHrKUIxh6e1WPDtEPk7cgyNsn
 +Yibpfsg+y+FNQTx5fdaEZ35rorUEbt0ktVRaLj6sf+CRO5cPXGmSRVBafJQ==
X-Received: by 2002:a17:907:948b:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c246a346d3amr3081412166b.9.1787578658405; 
 Mon, 24 Aug 2026 06:37:38 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:9048:7bf0:d3e2:2b9e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm1236658166b.38.2026.08.24.06.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:37:37 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v4 5/5] qcow2: repair a dirty image when it becomes writable
Date: Mon, 24 Aug 2026 15:37:29 +0200
Message-ID: <20260824133729.1141990-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824133729.1141990-1-den@openvz.org>
References: <20260824133729.1141990-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=den@openvz.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Denis V. Lunev <den@openvz.org>

A dirty image must be repaired before anything allocates a cluster in
it. qcow2_do_open() does that, but only for a node that is writable
from the start. A node opened read-only skips it, and nothing revisits
the question once that node becomes writable, which block-commit does
routinely: commit_active_start() and commit_start() reopen the base
read-write for the duration of the job.

With lazy refcounts the on-disk refcount block then still accounts for
the metadata clusters only, so the allocator restarts at the front of
the image and hands out clusters that L2 entries point at. Two guest
offsets end up sharing one host cluster. Nothing fails, the corrupt bit
stays clear, and a clean close clears the dirty bit, so no later open
repairs the image either. The bit also stays set for the whole writable
session, so a node which is merely writable says nothing.

Refusing the reopen instead is simpler and keeps it atomic, but it
leaves nowhere to go: the base belongs to a chain the VM has open, so
the qemu-img check -r such an error would ask for cannot take the write
lock it needs. The repair does the trick in most cases anyway.

Do the repair in qcow2_reopen_commit_post(), the earliest point where
the node is writable. An inactive node is skipped: bdrv_activate() calls
qcow2_do_open() again through qcow2_co_invalidate_cache().

commit_post cannot reject the reopen, so a failed repair takes the
driver away from the node instead, which is what stops writes from
aliasing live clusters. qcow2_signal_corruption() does that as well,
but it also sends BLOCK_IMAGE_CORRUPTED and sets the corrupt bit,
which qcow2_do_open() honours by refusing every later read-write open.
The image is dirty and unrepaired, not corrupt, and qemu-img check -r
still fixes it, so neither belongs here. Return the error and skip
the bitmaps.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
---
 block/qcow2.c              |  21 +++++++
 qapi/block-core.json       |  19 ++++++
 tests/qemu-iotests/039     |  60 ++++++++++++++++++
 tests/qemu-iotests/039.out |  36 +++++++++++
 tests/qemu-iotests/040     | 122 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out |   4 +-
 6 files changed, 260 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 553a94d003..e91523699f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2147,8 +2147,29 @@ static void qcow2_reopen_commit(BDRVReopenState *state)
 
 static int qcow2_reopen_commit_post(BDRVReopenState *state, Error **errp)
 {
+    ERRP_GUARD();
+    BDRVQcow2State *s = state->bs->opaque;
+
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
+    if (!bdrv_reopen_was_writable(state) && bdrv_is_writable(state->bs) &&
+        (s->incompatible_features & QCOW2_INCOMPAT_DIRTY)) {
+        BdrvCheckResult result = {0};
+        int ret;
+
+        ret = bdrv_check(state->bs, &result, BDRV_FIX_ERRORS | BDRV_FIX_LEAKS);
+        if (ret < 0 || result.check_errors || !state->bs->drv) {
+            ret = ret < 0 ? ret : -EIO;
+            /* No write may reach an image whose refcounts are unaccounted */
+            state->bs->drv = NULL;
+            error_setg_errno(errp, -ret, "Could not repair dirty image '%s'",
+                             bdrv_get_device_or_node_name(state->bs));
+            error_append_hint(errp, "The image is left dirty and this node "
+                              "holds it open until the node is removed\n");
+            return ret;
+        }
+    }
+
     if (state->flags & BDRV_O_RDWR) {
         Error *local_err = NULL;
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 199efc1e00..940249a5e5 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1852,6 +1852,9 @@
 # r/w -> r/o, if needed).  The new backing file string is written into
 # the image file metadata, and the QEMU internal strings are updated.
 #
+# A dirty qcow2 image is repaired during that reopen, which blocks
+# other requests and can fail the command.
+#
 # @image-node-name: The name of the block driver state node of the
 #     image to modify.  The "device" argument is used to verify
 #     "image-node-name" is in the chain described by "device".
@@ -1891,6 +1894,9 @@
 # size to match the size of the smaller top, you can safely truncate
 # it yourself once the commit operation successfully completes.
 #
+# The base is opened read-write.  A dirty qcow2 base is repaired
+# first, which blocks other requests and can fail the command.
+#
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
 #
@@ -2902,6 +2908,9 @@
 # On successful completion the image file is updated to drop the
 # backing file and the `BLOCK_JOB_COMPLETED` event is emitted.
 #
+# The top image is opened read-write.  A dirty qcow2 image is repaired
+# first, which blocks other requests and can fail the command.
+#
 # In case @device is a filter node, `block-stream` modifies the first
 # non-filter overlay node below it to point to the new backing node
 # instead of modifying @device itself.
@@ -4989,6 +4998,16 @@
 # transaction, so if one of them fails then the whole transaction is
 # cancelled.
 #
+# An error is also returned when a device cannot be used once it has
+# been reopened.  Such a reopen is not undone, so an error does not
+# always mean that nothing has changed.  A node the driver gave up on
+# serves nothing at all: it keeps its image open, makes
+# `query-named-block-nodes` fail for as long as it is in the graph,
+# and `blockdev-del` removes it only once nothing refers to it.
+#
+# Reopening a dirty qcow2 image read-write repairs it first, which
+# blocks other requests and can fail the command.
+#
 # The command receives a list of block devices to reopen.  For each
 # one of them, the top-level @node-name option (from
 # `BlockdevOptions`) must be specified and is used to select the block
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 3d0c073d65..3f37c36ca8 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -33,6 +33,7 @@ status=1	# failure is the default!
 _cleanup()
 {
 	_cleanup_test_img
+	rm -f "$TEST_DIR/blkdebug.conf"
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
@@ -176,6 +177,65 @@ $QEMU_IO -c "write 0 512" "$TEST_IMG" | _filter_qemu_io
 # The dirty bit must not be set
 _qcow2_dump_header | grep incompatible_features
 
+echo
+echo "== Reopening a dirty image read/write should repair it =="
+
+_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
+
+_NO_VALGRIND \
+$QEMU_IO -c "write -P 0x5a 0 512" \
+         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
+    | _filter_qemu_io
+
+# The dirty bit must be set
+_qcow2_dump_header | grep incompatible_features
+
+# Without the repair this write would alias the cluster at offset 0
+$QEMU_IO -r -c "reopen -w" \
+            -c "write -P 0xb1 1M 512" \
+            -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
+
+_check_test_img
+
+echo
+echo "== A read/write reopen must not check the image =="
+
+_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
+
+_NO_VALGRIND \
+$QEMU_IO -c "write -P 0x5a 0 512" \
+         -c "reopen -o l2-cache-size=1M" \
+         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
+    | _filter_qemu_io
+
+# The dirty bit must still be set, it belongs to the running session
+_qcow2_dump_header | grep incompatible_features
+
+echo
+echo "== A failed repair must fail the reopen =="
+
+_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
+
+_NO_VALGRIND \
+$QEMU_IO -c "write -P 0x5a 0 512" \
+         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
+    | _filter_qemu_io
+
+cat > "$TEST_DIR/blkdebug.conf" <<EOF
+[inject-error]
+event = "none"
+iotype = "write"
+errno = "5"
+EOF
+
+# The repair cannot write, so the reopen itself must report the failure
+$QEMU_IO -r -c "reopen -w" -c "read -P 0x5a 0 512" \
+    "blkdebug:$TEST_DIR/blkdebug.conf:$TEST_IMG" 2>&1 \
+    | _filter_testdir | _filter_qemu_io | _filter_generated_node_ids
+
+# The corrupt bit needs a write of its own, so the image is only left dirty
+_qcow2_dump_header | grep incompatible_features
+
 echo
 echo "== Creating an image file with lazy_refcounts=off =="
 
diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index ce8ee57721..cc6ca3ab95 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -79,6 +79,42 @@ wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 incompatible_features     []
 
+== Reopening a dirty image read/write should repair it ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+incompatible_features     [0]
+ERROR cluster 5 refcount=0 reference=1
+Rebuilding refcount structure
+Repairing cluster 1 refcount=1 reference=0
+Repairing cluster 2 refcount=1 reference=0
+wrote 512/512 bytes at offset 1048576
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+No errors were found on the image.
+
+== A read/write reopen must not check the image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+incompatible_features     [0]
+
+== A failed repair must fail the reopen ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+ERROR cluster 5 refcount=0 reference=1
+Rebuilding refcount structure
+qemu-io: ERROR writing refblock: Input/output error
+qemu-io: Could not repair dirty image 'NODE_NAME': Input/output error
+The image is left dirty and this node holds it open until the node is removed
+read failed: No medium found
+incompatible_features     [0]
+
 == Creating an image file with lazy_refcounts=off ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
diff --git a/tests/qemu-iotests/040 b/tests/qemu-iotests/040
index 5c18e413ec..452c87f9cd 100755
--- a/tests/qemu-iotests/040
+++ b/tests/qemu-iotests/040
@@ -951,6 +951,128 @@ class TestCommitWithOverriddenBacking(iotests.QMPTestCase):
         self.vm.qmp('block-job-complete', device='commit')
         self.vm.event_wait('BLOCK_JOB_COMPLETED')
 
+QCOW2_INCOMPAT_FEATURES_OFFSET = 72
+QCOW2_INCOMPAT_DIRTY = 1 << 0
+
+image_size = 4 * 1024 * 1024
+dirty_base = os.path.join(iotests.test_dir, 'dirty-base.img')
+mid = os.path.join(iotests.test_dir, 'dirty-mid.img')
+top = os.path.join(iotests.test_dir, 'dirty-top.img')
+
+
+class TestCommitDirtyBase(iotests.QMPTestCase):
+    def setUp(self) -> None:
+        if iotests.imgfmt != 'qcow2':
+            self.case_skip('the dirty bit is a qcow2 feature')
+        iotests.qemu_img_create('-f', iotests.imgfmt, '-o',
+                                'compat=1.1,lazy_refcounts=on', dirty_base,
+                                str(image_size))
+        # Killing the process leaves the refcounts of the written cluster stale
+        iotests.qemu_io_popen('-t', 'writethrough',
+                              '-c', 'write -P 0x5a 0 512',
+                              '-c', 'sigraise 9', dirty_base).communicate()
+        iotests.qemu_img_create('-f', iotests.imgfmt, '-b', dirty_base,
+                                '-F', iotests.imgfmt, mid)
+        iotests.qemu_img_create('-f', iotests.imgfmt, '-b', mid,
+                                '-F', iotests.imgfmt, top)
+        # The commit has to allocate for this, which is where the stale
+        # refcounts hand out the cluster holding the data written above
+        qemu_io('-c', 'write -P 0xb1 1M 512', mid)
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+        self.vm.cmd('blockdev-add', driver='file', filename=dirty_base,
+                    node_name='base-file')
+
+        self.assertEqual(self.incompatible_features(), QCOW2_INCOMPAT_DIRTY)
+
+    def tearDown(self) -> None:
+        if self.vm.is_running():
+            self.vm.shutdown()
+        for image in (dirty_base, mid, top):
+            os.remove(image)
+
+    def add_chain(self, base_file: str) -> None:
+        self.vm.cmd('blockdev-add', driver=iotests.imgfmt, file=base_file,
+                    node_name='base', read_only=True)
+        self.vm.cmd('blockdev-add', driver='file', filename=mid,
+                    node_name='mid-file')
+        self.vm.cmd('blockdev-add', driver=iotests.imgfmt, file='mid-file',
+                    node_name='mid', backing='base')
+        self.vm.cmd('blockdev-add', driver='file', filename=top,
+                    node_name='top-file')
+        self.vm.cmd('blockdev-add', driver=iotests.imgfmt, file='top-file',
+                    node_name='top', backing='mid')
+
+    def check_base(self) -> None:
+        result = iotests.qemu_img_check(dirty_base)
+        self.assertEqual(result['check-errors'], 0)
+        self.assertEqual(result.get('corruptions', 0), 0)
+        # Without the repair the commit would have aliased this cluster
+        qemu_io('-c', 'read -P 0x5a 0 512', '-c', 'read -P 0xb1 1M 512',
+                dirty_base)
+
+    def incompatible_features(self) -> int:
+        with open(dirty_base, 'rb') as img:
+            img.seek(QCOW2_INCOMPAT_FEATURES_OFFSET)
+            return struct.unpack('>Q', img.read(8))[0]
+
+    def test_commit_repairs_base(self) -> None:
+        self.add_chain('base-file')
+
+        self.vm.cmd('block-commit', job_id='job0', device='top',
+                    top_node='mid', base_node='base')
+        self.wait_until_completed(drive='job0')
+
+        self.vm.shutdown()
+        self.assertEqual(self.incompatible_features(), 0)
+        self.check_base()
+
+    def test_active_commit_repairs_base(self) -> None:
+        self.add_chain('base-file')
+
+        # Without top-node the whole chain commits, through
+        # commit_active_start() rather than commit_start()
+        self.vm.cmd('block-commit', job_id='job0', device='top',
+                    base_node='base')
+        self.complete_and_wait(drive='job0')
+
+        self.vm.shutdown()
+        self.assertEqual(self.incompatible_features(), 0)
+        self.check_base()
+
+    def test_failed_repair_fails_the_commit(self) -> None:
+        self.vm.cmd('blockdev-add', driver='blkdebug', image='base-file',
+                    node_name='base-blkdebug',
+                    inject_error=[{'event': 'none', 'iotype': 'write',
+                                   'errno': 5}])
+        self.add_chain('base-blkdebug')
+
+        result = self.vm.qmp('block-commit', job_id='job0', device='top',
+                             top_node='mid', base_node='base')
+        self.assert_qmp(result, 'error/class', 'GenericError')
+        self.assertIn("Could not repair dirty image 'base'",
+                      result['error']['desc'])
+
+        # The base is left in the graph, and nothing can be queried while
+        # it is there
+        result = self.vm.qmp('query-named-block-nodes', flat=True)
+        self.assert_qmp(result, 'error/desc', 'Block device base is ejected')
+
+        # It only goes away once nothing refers to it
+        result = self.vm.qmp('blockdev-del', node_name='base')
+        self.assert_qmp(result, 'error/desc',
+                        "Node 'base' is busy: node is used as backing hd of "
+                        "'mid'")
+
+        # Marking the image corrupt needs a write of its own, which fails too
+        self.assertEqual(self.incompatible_features(), QCOW2_INCOMPAT_DIRTY)
+
+        # Nothing can use the base any more, and that is what is reported
+        result = self.vm.qmp('block-commit', job_id='job1', device='top',
+                             top_node='mid', base_node='base')
+        self.assert_qmp(result, 'error/desc', 'Device has no medium')
+
 if __name__ == '__main__':
     iotests.main(supported_fmts=['qcow2', 'qed'],
                  supported_protocols=['file'])
diff --git a/tests/qemu-iotests/040.out b/tests/qemu-iotests/040.out
index 1bb1dc5f0e..f3cbf73a01 100644
--- a/tests/qemu-iotests/040.out
+++ b/tests/qemu-iotests/040.out
@@ -1,5 +1,5 @@
-.................................................................
+....................................................................
 ----------------------------------------------------------------------
-Ran 65 tests
+Ran 68 tests
 
 OK
-- 
2.53.0


