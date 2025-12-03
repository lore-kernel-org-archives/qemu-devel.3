Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E35BD116F3
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 09:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQjII-0000yh-5k; Wed, 03 Dec 2025 04:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjIB-0000rz-OG; Wed, 03 Dec 2025 04:37:01 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vQjI9-00078L-QZ; Wed, 03 Dec 2025 04:36:59 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2101A1708B8;
 Wed, 03 Dec 2025 12:35:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 095BA32B5AF;
 Wed, 03 Dec 2025 12:36:13 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 89/96] iotests: add Linux loop device image creation
 test
Date: Wed,  3 Dec 2025 12:35:22 +0300
Message-ID: <20251203093612.2370716-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251203111246@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

This qemu-iotests test case is based on the reproducer that Jean-Louis
Dupond <jean-louis@dupond.be> shared in
https://gitlab.com/qemu-project/qemu/-/issues/3127.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20251007141700.71891-4-stefanha@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 59a1cf0cd31597d2f6e2c18dc400a1de8427d47d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/loop-create-file b/tests/qemu-iotests/tests/loop-create-file
new file mode 100755
index 0000000000..5ec75b046b
--- /dev/null
+++ b/tests/qemu-iotests/tests/loop-create-file
@@ -0,0 +1,59 @@
+#!/usr/bin/env bash
+# group: quick
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright Red Hat, Inc.
+#
+# Test Linux loop device image creation
+#
+# This test verifies #3127 "qemu-img create fails on loop device with sector size 4096"
+# https://gitlab.com/qemu-project/qemu/-/issues/3127
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup() {
+    if [ -n "$loopdev" ]; then
+        sudo losetup --detach "$loopdev"
+    fi
+
+    _cleanup_test_img
+}
+
+trap "_cleanup; exit \$status" 0 1 2 3 15
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
+if ! sudo -n losetup &>/dev/null; then
+    _notrun "sudo losetup not available"
+fi
+
+echo
+echo "=== Create image on a 4 KB sector size loop device ==="
+echo
+
+_make_test_img -f $IMGFMT 1M
+
+loopdev=$(sudo losetup --sector-size 4096 --find --show "$TEST_IMG")
+if [ -z "$loopdev" ]; then
+    _fail
+fi
+
+sudo $QEMU_IMG_PROG create -f raw "$loopdev" 1M | \
+    sed -e "s#/dev/loop[0-9]\\+#LOOPDEV#g"
+
+# success, all done
+echo
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/loop-create-file.out b/tests/qemu-iotests/tests/loop-create-file.out
new file mode 100644
index 0000000000..32d4155695
--- /dev/null
+++ b/tests/qemu-iotests/tests/loop-create-file.out
@@ -0,0 +1,8 @@
+QA output created by loop-create-file
+
+=== Create image on a 4 KB sector size loop device ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+Formatting 'LOOPDEV', fmt=raw size=1048576
+
+*** done
-- 
2.47.3


