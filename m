Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7722ACA600B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnvd-0002iU-Sy; Thu, 08 Oct 2026 09:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvc-0002hv-0Z
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvX-0002Qz-LQ
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P4Mw8VjSbZuEI+0L/GJMBMQHuhWM969NgdNmzsTmg30=;
 b=AC2JnvyPez9JF4TI2jr/85/WIaau9iQrtleIASAFlfZZl5+IQUf3WFstDVBcFS/D9Y2FDF
 to9Ut2IkLYlATdevq3YxBpd+6tphNJ4eTXQaMFj9upBCo0Y7EfsrxBe1Q4XCPLkbJaX5h2
 H9dH51CusOcJxN2OZfSFFDVMDIFECus=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-Qpqnfu27OIK2pxjYZT8neQ-1; Thu,
 08 Oct 2026 09:12:48 -0400
X-MC-Unique: Qpqnfu27OIK2pxjYZT8neQ-1
X-Mimecast-MFC-AGG-ID: Qpqnfu27OIK2pxjYZT8neQ_1791465167
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 667301977305; Thu,  8 Oct 2026 13:12:47 +0000 (UTC)
Received: from eblake.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A4D7830001BB; Thu,  8 Oct 2026 13:12:38 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 05/15] block: report flush error during bdrv_close()
Date: Thu,  8 Oct 2026 08:11:44 -0500
Message-ID: <20261008131216.2437896-22-eblake@redhat.com>
In-Reply-To: <20261008131216.2437896-17-eblake@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 block.c                                    | 13 +++-
 tests/qemu-iotests/026                     | 10 +--
 tests/qemu-iotests/026.out                 | 84 ++++++++++++++++++++++
 tests/qemu-iotests/071                     |  2 +-
 tests/qemu-iotests/071.out                 |  2 +
 tests/qemu-iotests/080.out                 |  2 +
 tests/qemu-iotests/098.out                 |  4 ++
 tests/qemu-iotests/122                     |  8 +--
 tests/qemu-iotests/122.out                 |  2 +
 tests/qemu-iotests/244                     |  2 +-
 tests/qemu-iotests/244.out                 |  1 +
 tests/qemu-iotests/tests/file-io-error     |  2 +-
 tests/qemu-iotests/tests/file-io-error.out |  2 +
 tests/qemu-iotests/tests/qsd-migrate       |  5 +-
 tests/qemu-iotests/tests/qsd-migrate.out   |  1 +
 15 files changed, 125 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index f0a6042e616..c05ad01f25c 100644
--- a/block.c
+++ b/block.c
@@ -5162,12 +5162,23 @@ static void GRAPH_UNLOCKED bdrv_close(BlockDriverState *bs)
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
index b998a9ac83d..47bd88b1d3c 100644
--- a/tests/qemu-iotests/026.out
+++ b/tests/qemu-iotests/026.out
@@ -15,15 +15,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l1_update; errno: 5; imm: off; once: off; write
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l1_update; errno: 5; imm: off; once: off; write -b
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -39,15 +43,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l1_update; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l1_update; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -127,15 +135,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l2_update; errno: 5; imm: off; once: off; write
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l2_update; errno: 5; imm: off; once: off; write -b
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -151,15 +163,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l2_update; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l2_update; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -175,15 +191,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l2_alloc_write; errno: 5; imm: off; once: off; write
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l2_alloc_write; errno: 5; imm: off; once: off; write -b
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -199,15 +219,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l2_alloc_write; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l2_alloc_write; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -223,15 +247,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: write_aio; errno: 5; imm: off; once: off; write
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: write_aio; errno: 5; imm: off; once: off; write -b
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -247,15 +275,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: write_aio; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: write_aio; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -271,15 +303,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_load; errno: 5; imm: off; once: off; write
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_load; errno: 5; imm: off; once: off; write -b
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -295,15 +331,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_load; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_load; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -319,15 +359,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_update_part; errno: 5; imm: off; once: off; write
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_update_part; errno: 5; imm: off; once: off; write -b
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -343,15 +387,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_update_part; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_update_part; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -367,15 +415,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc; errno: 5; imm: off; once: off; write
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc; errno: 5; imm: off; once: off; write -b
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -391,15 +443,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -458,15 +514,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc_hookup; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -482,15 +542,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc_write; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -506,15 +570,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc_write_blocks; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -530,15 +598,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc_write_table; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -554,15 +626,19 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: refblock_alloc_switch_table; errno: 28; imm: off; once: off; write -b
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.

 === L1 growth tests ===
@@ -596,8 +672,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l1_grow_write_table; errno: 5; imm: off; once: off
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -608,8 +686,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l1_grow_write_table; errno: 28; imm: off; once: off
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -620,8 +700,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l1_grow_activate_table; errno: 5; imm: off; once: off
 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 qemu-io: Failed to flush the L2 table cache: Input/output error
 qemu-io: Failed to flush the refcount block cache: Input/output error
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: Input/output error
 No errors were found on the image.
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

@@ -632,8 +714,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824

 Event: l1_grow_activate_table; errno: 28; imm: off; once: off
 qemu-io: write failed: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 qemu-io: Failed to flush the L2 table cache: No space left on device
 qemu-io: Failed to flush the refcount block cache: No space left on device
+qemu-io: Failed flush for 'blkdebug:TEST_DIR/blkdebug.conf:TEST_DIR/t.qcow2' during close: No space left on device
 No errors were found on the image.

 === Avoid cluster leaks after temporary failure ===
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 83c4ce6314c..8237b325ea5 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -54,7 +54,7 @@ do_run_qemu()

 run_qemu()
 {
-    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp | _filter_qemu_io
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp | _filter_qemu_io | _filter_json_filename
 }

 IMG_SIZE=64M
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index f2d015d8cca..a69e6f7e501 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -83,8 +83,10 @@ wrote 512/512 bytes at offset 0
 {"return": ""}
 {"return": "Error: read failed: Input/output error\r\n"}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+QEMU_PROG: Failed flush for 'json:{ /* filtered */ }' during close: Input/output error
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error
+QEMU_PROG: Failed flush for 'json:{ /* filtered */ }' during close: Input/output error
 {"return": {}}

 *** done
diff --git a/tests/qemu-iotests/080.out b/tests/qemu-iotests/080.out
index b20c21faf6a..3b2b27c5fec 100644
--- a/tests/qemu-iotests/080.out
+++ b/tests/qemu-iotests/080.out
@@ -67,6 +67,7 @@ qemu-img: Failed to load snapshot: Snapshot L1 table offset invalid
 qemu-img: Snapshot L1 table offset invalid
 qemu-img: Failed to turn zero into data clusters: Invalid argument
 qemu-io: write failed: Invalid argument
+qemu-io: Failed flush for 'TEST_DIR/t.qcow2' during close: Invalid argument
 qemu-io: Failed to flush the refcount block cache: Invalid argument
 qemu-img: Snapshot L1 table offset invalid
 qemu-img: Could not apply snapshot 'test': Failed to load snapshot: Invalid argument
@@ -90,6 +91,7 @@ qemu-img: Failed to load snapshot: Snapshot L1 table too large
 qemu-img: Snapshot L1 table too large
 qemu-img: Failed to turn zero into data clusters: File too large
 qemu-io: write failed: File too large
+qemu-io: Failed flush for 'TEST_DIR/t.qcow2' during close: File too large
 qemu-io: Failed to flush the refcount block cache: File too large
 qemu-img: Snapshot L1 table too large
 qemu-img: Could not apply snapshot 'test': Failed to load snapshot: File too large
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
index 2a98ad58f5d..ef32f8ec036 100755
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
index c5e62146c93..81463d6f0ec 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -134,6 +134,7 @@ Images are identical.

 === Flushing should flush the data file ===

+qemu-io: Failed flush for 'NODE_NAME' during close: Input/output error
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)

diff --git a/tests/qemu-iotests/tests/file-io-error b/tests/qemu-iotests/tests/file-io-error
index 0d970c102f6..3885b741d99 100755
--- a/tests/qemu-iotests/tests/file-io-error
+++ b/tests/qemu-iotests/tests/file-io-error
@@ -94,7 +94,7 @@ echo "$output"

 echo
 # This should fail, but gracefully, i.e. just print an I/O error, not crash.
-$QEMU_IO -f file -c 'write 0 64M' "$TEST_DIR/fuse-export" | _filter_qemu_io
+$QEMU_IO -f file -c 'write 0 64M' "$TEST_DIR/fuse-export" 2>&1 | _filter_qemu_io | _filter_testdir
 echo

 capture_events=BLOCK_EXPORT_DELETED _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/tests/file-io-error.out b/tests/qemu-iotests/tests/file-io-error.out
index bf8c0018ba5..748ea3079c0 100644
--- a/tests/qemu-iotests/tests/file-io-error.out
+++ b/tests/qemu-iotests/tests/file-io-error.out
@@ -22,6 +22,7 @@ QA output created by file-io-error
 {"return": {}}

 qemu-io: write failed: Input/output error
+qemu-io: Failed flush for 'TEST_DIR/fuse-export' during close: Input/output error

 {'execute': 'block-export-del',
       'arguments': {'id': 'exp0'}}
@@ -29,5 +30,6 @@ qemu-io: write failed: Input/output error
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "exp0"}}
 {'execute': 'blockdev-del',
       'arguments': {'node-name': 'node0'}}
+QEMU_PROG: Failed flush for 'node0' during close: Input/output error
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/tests/qsd-migrate b/tests/qemu-iotests/tests/qsd-migrate
index d76278b576c..73583dec169 100755
--- a/tests/qemu-iotests/tests/qsd-migrate
+++ b/tests/qemu-iotests/tests/qsd-migrate
@@ -20,7 +20,7 @@

 import iotests

-from iotests import filter_qemu_io, filter_qtest
+from iotests import filter_qemu, filter_qemu_io, filter_qtest

 iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
                           supported_protocols=['file'],
@@ -126,11 +126,12 @@ with iotests.FilePath('disk.img') as path, \

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
2.56.0


