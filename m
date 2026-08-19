Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4596C5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:07:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwf3r-0004AL-Gi; Wed, 19 Aug 2026 08:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwf3j-00046d-Aq
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:06:20 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wwf3d-0007r5-50
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 08:06:17 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954a2e73a9so6208685e9.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 05:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787141168; x=1787745968; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+Qz5AEGImTZP6KcLGs93xFGKU7NSCedSN1v3EMrliUY=;
 b=LM7oXQVrfDplwqU4lpaI+EhBS1PWG9xEfU3WCt7uPMhhDGM+kaTxXo/4uhPgrF6XYP
 UOwL9aMcqrD+Zz0QwvrvEDgdvunWmkzICmjD8ZEkugk6dfrH0o/NXTzmozNX1Q5GAbma
 2McK1X8L2PCeOGmeGnV60pKybFaCdcJX0oCBIoVDwcPMX35NMkmqlIEKwb0UbdObqC3T
 N349d7mRbwWlfbosQToaMdVOH6tMfcy6y66z1q0YO7BlbqVX56nur2xg+JipStBoYH2b
 1qSD2j+B+KeSWCjmWrAKnlr1LXLCJGzoIq005B3JfuJHK+skdb4f9SADaIeryBAVTgMU
 KQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787141168; x=1787745968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+Qz5AEGImTZP6KcLGs93xFGKU7NSCedSN1v3EMrliUY=;
 b=ChkBDK5fmU8DpxOIUmUb61QbD6VQnStEyg2NqkYt1bvxPtclvwCYH+HZM26cG7z8Of
 jsrSWu0gLLK7xj8e0RcCGE0sK+ldBuyg0Rv0rBHGddkWShlSlzCKUUy6iZSzz5r4zVH0
 4uKJ/leX20v1R1y6CSyzgMQCKW1e/vlBzgv85pc+ty+LXJDepfL0y/SPNUhDD07Q8qTH
 6t2JjVTdWDF29w4wQJmmSYkjoby7dDcTMLgMsnk9m/RZLBYn7eQ2mzwAGgdO/nHYinaZ
 OFG3Z+L015GJWab/1KK6wNtjxKFydegcLXTzjegWSCOpI/1VT5BPA25neX4clOod2gzU
 uQTg==
X-Gm-Message-State: AOJu0YwgKS7/SL7ZiG46oybLRUunhGJy2yyspSsVD7ScM99iWc7cKTOU
 IivKcbVx/0ZK4zxyn3K8TjP/IHUFl3U+PoXgeEQuug1Xri3DZaiVAXEgihE7bMk57NRNJEJiBgv
 y3Xl2
X-Gm-Gg: AR+sD13/29OZkWJLRvvkdmZ1N0hDWpj77q5VLzPEEQCcjOo5AKY42O6be1a6abIfaIC
 PEXDh1lDrOR/+oBKcFCGntAKbHkNbf4UIblFWIuEAixd53jfFnmAFaFf/vGo7OAvU5XsaASCkHA
 qbqvSJ4svvfMiAtmtiMWxzSdYoAPYGg/wFU8cej/XRPNRZ5uZxO3XLtV6A+QmFqsRLtpSi601QI
 o/6ievSUpCNOg788CVuwszQhQp5PLm4CqIKO7XRC5+SJzZUeN9Em6FyeNq7ZxnAoLk6IX7eVmHC
 hdKmXo+3/FhsXFRBeMlZQRw3WNDKCS6eazdCLYK9+wmbKFZuGLmaV+uq7XUCIn1R5cjo0Rx8IgY
 rGhKI9RkErq1jFfieaOODvBBQPMX3lrKGat2ptH5sOAnXeCdn05fJDDJSA5iQLlAHiICPyxCPS2
 TSzvo8G4geJAWBqiQLnxBjGyP0/ND/2hH0XyeNVQPcYvGJE2CzWsK/62tEZg==
X-Received: by 2002:a05:600c:a412:b0:499:ae94:be05 with SMTP id
 5b1f17b1804b1-499ae94be48mr31316465e9.0.1787141168067; 
 Wed, 19 Aug 2026 05:06:08 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:258d:1706:7089:f765])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1111a7sm59244785e9.6.2026.08.19.05.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 05:06:07 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: [PATCH v3 5/5] qcow2: repair a dirty image when it becomes writable
Date: Wed, 19 Aug 2026 14:05:58 +0200
Message-ID: <20260819120558.3870413-6-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819120558.3870413-1-den@openvz.org>
References: <20260819120558.3870413-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=den@openvz.org; helo=mail-wm1-x32f.google.com
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

commit_post cannot reject the reopen, so a failed repair leaves only
what qcow2_signal_corruption() does, take the driver away from the node,
rather than let writes alias live clusters. Return the error and skip
the bitmaps.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
---
 block/qcow2.c              |  21 +++++++
 qapi/block-core.json       |  16 +++++
 tests/qemu-iotests/039     |  60 ++++++++++++++++++
 tests/qemu-iotests/039.out |  36 +++++++++++
 tests/qemu-iotests/040     | 122 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/040.out |   4 +-
 6 files changed, 257 insertions(+), 2 deletions(-)

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
index 199efc1e00..9aec081f7b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1891,6 +1891,11 @@
 # size to match the size of the smaller top, you can safely truncate
 # it yourself once the commit operation successfully completes.
 #
+# The base is opened read-write for the duration of the job.  A dirty
+# qcow2 base is repaired first, which reads all of its metadata and
+# holds up every other request while it runs.  The command fails if
+# that repair does not succeed.
+#
 # @job-id: identifier for the newly-created block job.  If omitted,
 #     the device name will be used.  (Since 2.7)
 #
@@ -4989,6 +4994,17 @@
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
+# reads all of its metadata and holds up every other request while it
+# runs.
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


