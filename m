Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89313606A31D
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=DpJq+H+O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLLAV-00051d-8W; Mon, 26 Oct 2026 09:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAQ-0004yt-PC; Mon, 26 Oct 2026 09:55:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xLLAK-0008WU-Se; Mon, 26 Oct 2026 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1793022903; bh=HkiYIZF879wm5/edXQ6o2erekQ+HkLW9mqmtJCOCAcc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DpJq+H+OozO+tLkhdwTt0nZMq+v6nNKVbozbCFVd4lT3VvIOcQusHPrJlfJbe409h
 8vB8fNzvCAWXhiE/8QKfVx/ERbWkXA1kaLL4TiIvjc8mF326sCYFEkt5sAPClHw93R
 EnT1a0YI/aVNo2dU0P/MugdhJjYe2ekE9yA/dsMEVbvQxp6mES0SSIQQZymrw8SjsA
 ZPUppw+qZDvmbVwSY6XRKOgEuPqUXO3GOyuPAQOBavlQn3Q44HWFhP8e62lyBPfxEM
 GtGWIH+OxLa2hMj7TwuOtRGV1hWNINe8N0JyU7ivWl77QlEwedQ/p3uks6ESofUgT7
 j7RcDVPKiLJYg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 92BFC1E127A;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8D9FF44B8C6;
 Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8285993483; Mon, 26 Oct 2026 16:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Eric Blake <eblake@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.15 v2 68/91] block: report flush error during
 bdrv_close()
Date: Mon, 26 Oct 2026 16:54:11 +0300
Message-ID: <20261026135441.1019505-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
References: <qemu-stable-10.0.15-20261026165128@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fiona Ebner <f.ebner@proxmox.com>

Flush during bdrv_close() was introduced back in 2012 in commit
80ccf93b88 ("qemu-img: let 'qemu-img convert' flush data"). However, a
failing flush was quietly ignored [0]. Report the error instead, since
this could mean that the image contents are not as expected.

Adapt the iotests accordingly. For all tests except '080' and
'qsd-migrate' the failures come from blkdebug configurations. For
'080', the failures are also directly expected, because of invalid L1
table size and offset. For the 'qsd-migrate' test, the error happens,
because the QSD node which is attached via NBD to the source VM was
inactivated.

[0]: Note that the errors reported for qcow2 come from
qcow2_inactivate() which is only called as part of
bs->drv->bdrv_close() after bdrv_flush(). In particular, adding
> 'once': 'on'
to the blkdebug driver in the relevant test case in the 122 iotest
shows that the failure can be silent in case of qcow2 too.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260930132140.2342574-4-f.ebner@proxmox.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
(cherry picked from commit c6c8bdc21af335ad72c899609d24844415a5af81)
(Mjt: fixups in tests output due to error hanling differences)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block.c b/block.c
index 0875e92536b..642778b0047 100644
--- a/block.c
+++ b/block.c
@@ -5152,12 +5152,23 @@ static void bdrv_close(BlockDriverState *bs)
 {
     BdrvAioNotifier *ban, *ban_next;
     BdrvChild *child, *next;
+    int ret;
 
     GLOBAL_STATE_CODE();
     assert(!bs->refcnt);
 
     bdrv_drained_begin(bs); /* complete I/O */
-    bdrv_flush(bs);
+    ret = bdrv_flush(bs);
+    if (ret < 0) {
+        const char *name;
+        if (bs->filename[0]) {
+            name = bs->filename;
+        } else {
+            name = bdrv_get_node_name(bs);
+        }
+        error_report("Failed flush for '%s' during close: %s", name,
+                     strerror(-ret));
+    }
     bdrv_drain(bs); /* in case flush left pending I/O */
 
     if (bs->drv) {
diff --git a/tests/qemu-iotests/026 b/tests/qemu-iotests/026
index d37e266dade..88cb4dd934e 100755
--- a/tests/qemu-iotests/026
+++ b/tests/qemu-iotests/026
@@ -103,13 +103,13 @@ if [ "$event" == "l2_update" ]; then
     $QEMU_IO -c "write $vmstate 0 512" "$TEST_IMG" > /dev/null 2>&1
 fi
 
-$QEMU_IO -c "write $vmstate 0 128k " "$BLKDBG_TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write $vmstate 0 128k " "$BLKDBG_TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 
 # l2_load is not called on allocation, so issue a second write
 # Reads are another path to trigger l2_load, so do a read, too
 if [ "$event" == "l2_load" ]; then
-    $QEMU_IO -c "write $vmstate 0 128k " "$BLKDBG_TEST_IMG" | _filter_qemu_io
-    $QEMU_IO -c "read $vmstate 0 128k " "$BLKDBG_TEST_IMG" | _filter_qemu_io
+    $QEMU_IO -c "write $vmstate 0 128k " "$BLKDBG_TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
+    $QEMU_IO -c "read $vmstate 0 128k " "$BLKDBG_TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 fi
 
 _check_test_img_ignore_leaks 2>&1 | grep -v "refcount=1 reference=0"
@@ -155,7 +155,7 @@ _make_test_img 1G
 
 echo
 echo "Event: $event; errno: $errno; imm: $imm; once: $once; write $vmstate"
-$QEMU_IO -c "write $vmstate 0 64M" "$BLKDBG_TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write $vmstate 0 64M" "$BLKDBG_TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 
 _check_test_img_ignore_leaks 2>&1 | grep -v "refcount=1 reference=0"
 
@@ -194,7 +194,7 @@ _make_test_img 1G
 
 echo
 echo "Event: $event; errno: $errno; imm: $imm; once: $once"
-$QEMU_IO -c "write -b 0 64k" "$BLKDBG_TEST_IMG" | _filter_qemu_io
+$QEMU_IO -c "write -b 0 64k" "$BLKDBG_TEST_IMG" 2>&1 | _filter_qemu_io | _filter_testdir
 
 _check_test_img_ignore_leaks 2>&1 | grep -v "refcount=1 reference=0"
 
diff --git a/tests/qemu-iotests/026.out b/tests/qemu-iotests/026.out
index 83989996ff6..c8d36899275 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -14,15 +14,19 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: off; write
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 5; imm: off; once: off; write -b
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -38,15 +42,19 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: off; write
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_update; errno: 28; imm: off; once: off; write -b
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -126,15 +134,19 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: off; write
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 5; imm: off; once: off; write -b
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -150,15 +162,19 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: off; write
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_update; errno: 28; imm: off; once: off; write -b
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -174,15 +190,19 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 5; imm: off; once: off; write -b
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 write failed: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -198,15 +218,19 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l2_alloc_write; errno: 28; imm: off; once: off; write -b
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 write failed: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
@@ -222,16 +246,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
+=======
+qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 5; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
+=======
+qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -246,16 +286,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 28; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: write_aio; errno: 28; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -270,16 +326,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
+=======
+qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 5; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
+=======
+qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -294,16 +366,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_load; errno: 28; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -318,16 +406,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
+=======
+qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 5; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
+=======
+qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -342,16 +446,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_update_part; errno: 28; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -366,16 +486,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
+=======
+qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 5; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
+=======
+qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -390,16 +526,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc; errno: 28; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -457,16 +609,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -481,16 +649,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -505,16 +689,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -529,16 +729,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -553,16 +769,32 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write -b
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 
 === L1 growth tests ===
@@ -595,9 +827,17 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 5; imm: off; once: off
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
+=======
+qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -607,9 +847,17 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_write_table; errno: 28; imm: off; once: off
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -619,9 +867,17 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 5; imm: off; once: off
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
 write failed: Input/output error
+=======
+qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+qemu-io: Failed to flush the L2 table cache: Input/output error
+qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
@@ -631,9 +887,17 @@ No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
 
 Event: l1_grow_activate_table; errno: 28; imm: off; once: off
+<<<<<<< HEAD
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
 write failed: No space left on device
+=======
+qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+qemu-io: Failed to flush the L2 table cache: No space left on device
+qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
+>>>>>>> c6c8bdc21af (block: report flush error during bdrv_close())
 No errors were found on the image.
 
 === Avoid cluster leaks after temporary failure ===
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 331f8cfddcf..3058db5bced 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -53,7 +53,7 @@ do_run_qemu()
 
 run_qemu()
 {
-    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp | _filter_qemu_io
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp | _filter_qemu_io | _filter_json_filename
 }
 
 IMG_SIZE=64M
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index a2923b05c29..4014ae2bb3a 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -85,8 +85,10 @@ wrote 512/512 bytes at offset 0
 read failed: Input/output error
 {"return": ""}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+QEMU_PROG: Failed flush for 'json:{ /* filtered */ }' during close: Input/output error
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error
+QEMU_PROG: Failed flush for 'json:{ /* filtered */ }' during close: Input/output error
 {"return": {}}
 
 *** done
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index d8acb3e7235..4534ca1219e 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -66,6 +66,7 @@ wrote 512/512 bytes at offset 0
 qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
 qemu-img: Snapshot L1 table offset invalid
 qemu-img: Failed to turn zero into data clusters: Invalid argument
+qemu-io: Failed flush for 'TEST_DIR/t.qcow2' during close: Invalid argument
 qemu-io: Failed to flush the refcount block cache: Invalid argument
 write failed: Invalid argument
 qemu-img: Snapshot L1 table offset invalid
@@ -89,6 +90,7 @@ wrote 512/512 bytes at offset 0
 qemu-img: Failed to load snapshot: Snapshot L1 table too large
 qemu-img: Snapshot L1 table too large
 qemu-img: Failed to turn zero into data clusters: File too large
+qemu-io: Failed flush for 'TEST_DIR/t.qcow2' during close: File too large
 qemu-io: Failed to flush the refcount block cache: File too large
 write failed: File too large
 qemu-img: Snapshot L1 table too large
diff --git a/tests/qemu-iotests/098.out b/tests/qemu-iotests/098.out
index 6c73dd0977f..912b0290af0 100644
--- a/tests/qemu-iotests/098.out
+++ b/tests/qemu-iotests/098.out
@@ -6,6 +6,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT' during close: Input/output error
 qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
 No errors were found on the image.
 
@@ -15,6 +16,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT' during close: Input/output error
 qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
 Leaked cluster 4 refcount=1 reference=0
 Leaked cluster 5 refcount=1 reference=0
@@ -28,6 +30,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT' during close: Input/output error
 qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
@@ -42,6 +45,7 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT' during close: Input/output error
 qemu-img: Failed to empty blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.IMGFMT: Input/output error
 ERROR cluster 0 refcount=0 reference=1
 ERROR cluster 1 refcount=0 reference=1
diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index 488649f1bd0..9da1246f097 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -357,15 +357,15 @@ target_fails_flush="json:{
     }
 }"
 
-$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG".orig "$target_fails_flush"
-echo "qemu-img convert exited with status $?"
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG".orig "$target_fails_flush" 2>&1 | _filter_json_filename
+echo "qemu-img convert exited with status ${PIPESTATUS[0]}"
 
 echo
 echo "=== failing flush after convert with 'writeback' cache mode ==="
 echo
 
-$QEMU_IMG convert -t writeback -f $IMGFMT -O $IMGFMT -n "$TEST_IMG".orig "$target_fails_flush"
-echo "qemu-img convert exited with status $?"
+$QEMU_IMG convert -t writeback -f $IMGFMT -O $IMGFMT -n "$TEST_IMG".orig "$target_fails_flush" 2>&1 | _filter_json_filename
+echo "qemu-img convert exited with status ${PIPESTATUS[0]}"
 
 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index f3e28f33bc2..84283f24343 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -267,7 +267,9 @@ qemu-img convert exited with status 0
 
 === failing flush after convert with 'writeback' cache mode ===
 
+qemu-img: Failed flush for 'json:{ /* filtered */ }' during close: Input/output error
 qemu-img: Failed to flush the L2 table cache: Input/output error
 qemu-img: Failed to flush the refcount block cache: Input/output error
+qemu-img: Failed flush for 'json:{ /* filtered */ }' during close: Input/output error
 qemu-img convert exited with status 0
 *** done
diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index bb9cc6512f3..97f1307eee0 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -264,7 +264,7 @@ $QEMU_IO -c 'write 0 512' -c flush \
              }
          }
      }" \
-    | _filter_qemu_io
+    2>&1 | _filter_qemu_io | _filter_generated_node_ids
 
 result=${PIPESTATUS[0]}
 echo
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index f46cfe93f11..f2fa00edfb3 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -134,6 +134,7 @@ Images are identical.
 
 === Flushing should flush the data file ===
 
+qemu-io: Failed flush for 'NODE_NAME' during close: Input/output error
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/tests/file-io-error
index fb8db73b31b..5a34d90a386 100755
--- a/tests/qemu-iotests/tests/file-io-error
+++ b/tests/qemu-iotests/tests/file-io-error
@@ -96,7 +96,7 @@ echo "$output"
 
 echo
 # This should fail, but gracefully, i.e. just print an I/O error, not crash.
-$QEMU_IO -f file -c 'write 0 64M' "$TEST_DIR/fuse-export" | _filter_qemu_io
+$QEMU_IO -f file -c 'write 0 64M' "$TEST_DIR/fuse-export" 2>&1 | _filter_qemu_io | _filter_testdir
 echo
 
 capture_events=BLOCK_EXPORT_DELETED _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/tests/file-io-error.out b/tests/qemu-iotests/tests/file-io-error.out
index 0f46455a94a..b5ac8d3db14 100644
--- a/tests/qemu-iotests/tests/file-io-error.out
+++ b/tests/qemu-iotests/tests/file-io-error.out
@@ -21,6 +21,7 @@ QA output created by file-io-error
       }}
 {"return": {}}
 
+qemu-io: Failed flush for 'TEST_DIR/fuse-export' during close: Input/output error
 write failed: Input/output error
 
 {'execute': 'block-export-del',
@@ -29,5 +30,6 @@ write failed: Input/output error
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "exp0"}}
 {'execute': 'blockdev-del',
       'arguments': {'node-name': 'node0'}}
+QEMU_PROG: Failed flush for 'node0' during close: Input/output error
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/tests/qsd-migrate b/tests/qemu-iotests/tests/qsd-migrate
index a4c6592420c..3fb5b2e475d 100755
--- a/tests/qemu-iotests/tests/qsd-migrate
+++ b/tests/qemu-iotests/tests/qsd-migrate
@@ -20,7 +20,7 @@
 
 import iotests
 
-from iotests import filter_qemu_io, filter_qtest
+from iotests import filter_qemu, filter_qemu_io, filter_qtest
 
 iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
                           supported_protocols=['file'],
@@ -125,11 +125,12 @@ with iotests.FilePath('disk.img') as path, \
 
     iotests.log('\nDone')
 
+    # NOTE: Flush during close fails here, since the QSD node was inactivated.
     vm_src.shutdown()
     iotests.log('\n--- vm_src log ---')
     log = vm_src.get_log()
     if log:
-        iotests.log(log, [filter_qtest, filter_qemu_io])
+        iotests.log(log, [filter_qtest, filter_qemu_io, filter_qemu])
     qsd_src.stop()
 
     vm_dst.shutdown()
diff --git a/tests/qemu-iotests/tests/qsd-migrate.out b/tests/qemu-iotests/tests/qsd-migrate.out
index 4a5241e5d40..894b232b4a4 100644
--- a/tests/qemu-iotests/tests/qsd-migrate.out
+++ b/tests/qemu-iotests/tests/qsd-migrate.out
@@ -47,6 +47,7 @@ read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+QEMU_PROG: Failed flush for 'disk' during close: Operation not permitted
 
 --- vm_dst log ---
 read 4096/4096 bytes at offset 0
-- 
2.47.3


