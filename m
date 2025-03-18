Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DA5C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 20:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tudIh-0006gu-Sk; Tue, 18 Mar 2025 16:12:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tudID-0006cy-7V
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 16:12:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tudIA-0000xC-0x
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 16:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742328717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2jmoAz3sL13SAohdW0BelHNoGDX43Ro6L12ixJug0qw=;
 b=cwjbsidMjBFunmcDWzO8m2mu/hAJD+AXGiwFzzbjd3KqSFlK0XwBB6fXBOzVKKjkv2qWd1
 juRNq5p2Yls56vc5jEfuUzulZ27xO7l3YvcjxefJzzbOk4IcI7D7bBhNbb2mjdexYwsRoQ
 4M/GwcSMr1KEzUXyFSEz7kdP7JHwX2o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-225-rXFcD_p1NnuZfBSqiu10Yg-1; Tue,
 18 Mar 2025 16:11:53 -0400
X-MC-Unique: rXFcD_p1NnuZfBSqiu10Yg-1
X-Mimecast-MFC-AGG-ID: rXFcD_p1NnuZfBSqiu10Yg_1742328711
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C86DB1955DCE; Tue, 18 Mar 2025 20:11:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.124])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B17281956094; Tue, 18 Mar 2025 20:11:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, gerben@altlinux.org,
 qemu-devel@nongnu.org
Subject: [PATCH] qcow2: Don't crash qemu-img info with missing crypto header
Date: Tue, 18 Mar 2025 21:11:43 +0100
Message-ID: <20250318201143.70657-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qcow2_refresh_limits() assumes that s->crypto is non-NULL whenever
bs->encrypted is true. This is actually not the case: qcow2_do_open()
allows to open an image with a missing crypto header for BDRV_O_NO_IO,
and then bs->encrypted is true, but s->crypto is still NULL.

It doesn't make sense to open an invalid image, so remove the exception
for BDRV_O_NO_IO. This catches the problem early and any code that makes
the same assumption is safe now.

At the same time, in the name of defensive programming, we shouldn't
make the assumption in the first place. Let qcow2_refresh_limits() check
s->crypto rather than bs->encrypted. If s->crypto is NULL, it also can't
make any requirement on request alignment.

Finally, start a qcow2-encryption test case that only serves as a
regression test for this crash for now.

Reported-by: Leonid Reviakin <L.reviakin@fobos-nt.ru>
Reported-by: Denis Rastyogin <gerben@altlinux.org>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c                                 |  4 +-
 tests/qemu-iotests/tests/qcow2-encryption     | 75 +++++++++++++++++++
 tests/qemu-iotests/tests/qcow2-encryption.out | 32 ++++++++
 3 files changed, 109 insertions(+), 2 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/qcow2-encryption
 create mode 100644 tests/qemu-iotests/tests/qcow2-encryption.out

diff --git a/block/qcow2.c b/block/qcow2.c
index dd6bcafbd8..7774e7f090 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -1721,7 +1721,7 @@ qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
                 ret = -EINVAL;
                 goto fail;
             }
-        } else if (!(flags & BDRV_O_NO_IO)) {
+        } else {
             error_setg(errp, "Missing CRYPTO header for crypt method %d",
                        s->crypt_method_header);
             ret = -EINVAL;
@@ -1976,7 +1976,7 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
 
-    if (bs->encrypted) {
+    if (s->crypto) {
         /* Encryption works on a sector granularity */
         bs->bl.request_alignment = qcrypto_block_get_sector_size(s->crypto);
     }
diff --git a/tests/qemu-iotests/tests/qcow2-encryption b/tests/qemu-iotests/tests/qcow2-encryption
new file mode 100755
index 0000000000..95f6195ab8
--- /dev/null
+++ b/tests/qemu-iotests/tests/qcow2-encryption
@@ -0,0 +1,75 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Test case for encryption support in qcow2
+#
+# Copyright (C) 2025 Red Hat, Inc.
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
+# creator
+owner=kwolf@redhat.com
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ../common.rc
+. ../common.filter
+
+# This tests qcow2-specific low-level functionality
+_supported_fmt qcow2
+_supported_proto file
+_require_working_luks
+
+IMG_SIZE=64M
+
+echo
+echo "=== Create an encrypted image ==="
+echo
+
+_make_test_img --object secret,id=sec0,data=123456 -o encrypt.format=luks,encrypt.key-secret=sec0 $IMG_SIZE
+$PYTHON ../qcow2.py "$TEST_IMG" dump-header-exts
+_img_info
+$QEMU_IMG check \
+    --object secret,id=sec0,data=123456 \
+    --image-opts file.filename="$TEST_IMG",encrypt.key-secret=sec0 \
+    | _filter_qemu_img_check
+
+echo
+echo "=== Remove the header extension ==="
+echo
+
+$PYTHON ../qcow2.py "$TEST_IMG" del-header-ext 0x0537be77
+$PYTHON ../qcow2.py "$TEST_IMG" dump-header-exts
+_img_info
+$QEMU_IMG check \
+    --object secret,id=sec0,data=123456 \
+    --image-opts file.filename="$TEST_IMG",encrypt.key-secret=sec0 2>&1 \
+    | _filter_qemu_img_check \
+    | _filter_testdir
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/qcow2-encryption.out b/tests/qemu-iotests/tests/qcow2-encryption.out
new file mode 100644
index 0000000000..9b549dc2ab
--- /dev/null
+++ b/tests/qemu-iotests/tests/qcow2-encryption.out
@@ -0,0 +1,32 @@
+QA output created by qcow2-encryption
+
+=== Create an encrypted image ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
+Header extension:
+magic                     0x537be77 (Crypto header)
+length                    16
+data                      <binary>
+
+Header extension:
+magic                     0x6803f857 (Feature table)
+length                    384
+data                      <binary>
+
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64 MiB (67108864 bytes)
+encrypted: yes
+cluster_size: 65536
+No errors were found on the image.
+
+=== Remove the header extension ===
+
+Header extension:
+magic                     0x6803f857 (Feature table)
+length                    384
+data                      <binary>
+
+qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Missing CRYPTO header for crypt method 2
+qemu-img: Could not open 'file.filename=TEST_DIR/t.qcow2,encrypt.key-secret=sec0': Missing CRYPTO header for crypt method 2
+*** done
-- 
2.48.1


