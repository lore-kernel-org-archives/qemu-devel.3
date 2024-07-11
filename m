Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E074C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 09:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpva-000242-Oz; Thu, 11 Jul 2024 05:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpvY-0001wR-TN
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpvW-00008C-Mj
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720689442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fYutXsBs1azmw7mKVZFdvjLwxwQKCo7DhYAFGp85DJE=;
 b=U6BUUK4tuInVZ67+NqjQB17sa0BIjiPT8SVQGuQV2QqxU4B1Dpksq80Oc9boEpx3fNAC+g
 9xN+AuZDhKxweAdI+9nNSYb8/ojpVWhof31q0wRnOUn8Dkq77J6vshPVKUYNPp71yDnooW
 NMIY7vo8byMnVg3sQ+1LgEq5nra5MaE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-sn6_mWhhMjGcfrmkXkASEQ-1; Thu,
 11 Jul 2024 05:17:18 -0400
X-MC-Unique: sn6_mWhhMjGcfrmkXkASEQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4313F1955F3B; Thu, 11 Jul 2024 09:17:17 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9152B1955F3B; Thu, 11 Jul 2024 09:17:16 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>,
 Nir Soffer <nsoffer@redhat.com>
Subject: [PULL 2/2] Consider discard option when writing zeros
Date: Thu, 11 Jul 2024 11:17:09 +0200
Message-ID: <20240711091709.584450-3-stefanha@redhat.com>
In-Reply-To: <20240711091709.584450-1-stefanha@redhat.com>
References: <20240711091709.584450-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Nir Soffer <nsoffer@redhat.com>

When opening an image with discard=off, we punch hole in the image when
writing zeroes, making the image sparse. This breaks users that want to
ensure that writes cannot fail with ENOSPACE by using fully allocated
images[1].

bdrv_co_pwrite_zeroes() correctly disables BDRV_REQ_MAY_UNMAP if we
opened the child without discard=unmap or discard=on. But we don't go
through this function when accessing the top node. Move the check down
to bdrv_co_do_pwrite_zeroes() which seems to be used in all code paths.

This change implements the documented behavior, punching holes only when
opening the image with discard=on or discard=unmap. This may not be the
best default but can improve it later.

The test depends on a file system supporting discard, deallocating the
entire file when punching hole with the length of the entire file.
Tested with xfs, ext4, and tmpfs.

[1] https://lists.nongnu.org/archive/html/qemu-discuss/2024-06/msg00003.html

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Message-id: 20240628202058.1964986-3-nsoffer@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/io.c                                    |   9 +-
 tests/qemu-iotests/tests/write-zeroes-unmap   | 127 ++++++++++++++++++
 .../qemu-iotests/tests/write-zeroes-unmap.out |  81 +++++++++++
 3 files changed, 213 insertions(+), 4 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/write-zeroes-unmap
 create mode 100644 tests/qemu-iotests/tests/write-zeroes-unmap.out

diff --git a/block/io.c b/block/io.c
index 7217cf811b..301514c880 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1862,6 +1862,11 @@ bdrv_co_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int64_t bytes,
         return -EINVAL;
     }
 
+    /* If opened with discard=off we should never unmap. */
+    if (!(bs->open_flags & BDRV_O_UNMAP)) {
+        flags &= ~BDRV_REQ_MAY_UNMAP;
+    }
+
     /* Invalidate the cached block-status data range if this write overlaps */
     bdrv_bsc_invalidate_range(bs, offset, bytes);
 
@@ -2315,10 +2320,6 @@ int coroutine_fn bdrv_co_pwrite_zeroes(BdrvChild *child, int64_t offset,
     trace_bdrv_co_pwrite_zeroes(child->bs, offset, bytes, flags);
     assert_bdrv_graph_readable();
 
-    if (!(child->bs->open_flags & BDRV_O_UNMAP)) {
-        flags &= ~BDRV_REQ_MAY_UNMAP;
-    }
-
     return bdrv_co_pwritev(child, offset, bytes, NULL,
                            BDRV_REQ_ZERO_WRITE | flags);
 }
diff --git a/tests/qemu-iotests/tests/write-zeroes-unmap b/tests/qemu-iotests/tests/write-zeroes-unmap
new file mode 100755
index 0000000000..7cfeeaf839
--- /dev/null
+++ b/tests/qemu-iotests/tests/write-zeroes-unmap
@@ -0,0 +1,127 @@
+#!/usr/bin/env bash
+# group: quick
+#
+# Test write zeros unmap.
+#
+# Copyright (C) Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+trap _cleanup_test_img exit
+
+# get standard environment, filters and checks
+cd ..
+. ./common.rc
+. ./common.filter
+
+_supported_fmt raw
+_supported_proto file
+_supported_os Linux
+
+create_test_image() {
+    _make_test_img -f $IMGFMT 1m
+}
+
+filter_command() {
+    _filter_testdir | _filter_qemu_io | _filter_qemu | _filter_hmp
+}
+
+print_disk_usage() {
+    du -sh $TEST_IMG | _filter_testdir
+}
+
+echo
+echo "=== defaults - write zeros ==="
+echo
+
+create_test_image
+echo -e 'qemu-io none0 "write -z 0 1m"\nquit' \
+    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT \
+    | filter_command
+print_disk_usage
+
+echo
+echo "=== defaults - write zeros unmap ==="
+echo
+
+create_test_image
+echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' \
+    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT \
+    | filter_command
+print_disk_usage
+
+
+echo
+echo "=== defaults - write actual zeros ==="
+echo
+
+create_test_image
+echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' \
+    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT \
+    | filter_command
+print_disk_usage
+
+echo
+echo "=== discard=off - write zeroes unmap ==="
+echo
+
+create_test_image
+echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' \
+    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,discard=off \
+    | filter_command
+print_disk_usage
+
+echo
+echo "=== detect-zeroes=on - write actual zeros ==="
+echo
+
+create_test_image
+echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' \
+    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,detect-zeroes=on \
+    | filter_command
+print_disk_usage
+
+echo
+echo "=== detect-zeroes=on,discard=on - write actual zeros ==="
+echo
+
+create_test_image
+echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' \
+    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,detect-zeroes=on,discard=on \
+    | filter_command
+print_disk_usage
+
+echo
+echo "=== discard=on - write zeroes ==="
+echo
+
+create_test_image
+echo -e 'qemu-io none0 "write -z 0 1m"\nquit' \
+    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,discard=on \
+    | filter_command
+print_disk_usage
+
+echo
+echo "=== discard=on - write zeroes unmap ==="
+echo
+
+create_test_image
+echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' \
+    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,discard=on \
+    | filter_command
+print_disk_usage
diff --git a/tests/qemu-iotests/tests/write-zeroes-unmap.out b/tests/qemu-iotests/tests/write-zeroes-unmap.out
new file mode 100644
index 0000000000..c931994897
--- /dev/null
+++ b/tests/qemu-iotests/tests/write-zeroes-unmap.out
@@ -0,0 +1,81 @@
+QA output created by write-zeroes-unmap
+
+=== defaults - write zeros ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io none0 "write -z 0 1m"
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+1.0M	TEST_DIR/t.raw
+
+=== defaults - write zeros unmap ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io none0 "write -zu 0 1m"
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+1.0M	TEST_DIR/t.raw
+
+=== defaults - write actual zeros ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io none0 "write -P 0 0 1m"
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+1.0M	TEST_DIR/t.raw
+
+=== discard=off - write zeroes unmap ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io none0 "write -zu 0 1m"
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+1.0M	TEST_DIR/t.raw
+
+=== detect-zeroes=on - write actual zeros ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io none0 "write -P 0 0 1m"
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+1.0M	TEST_DIR/t.raw
+
+=== detect-zeroes=on,discard=on - write actual zeros ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io none0 "write -P 0 0 1m"
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+1.0M	TEST_DIR/t.raw
+
+=== discard=on - write zeroes ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io none0 "write -z 0 1m"
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+1.0M	TEST_DIR/t.raw
+
+=== discard=on - write zeroes unmap ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) qemu-io none0 "write -zu 0 1m"
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+(qemu) quit
+0	TEST_DIR/t.raw
-- 
2.45.2


