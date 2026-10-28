Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D7606A326
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V6Z0dX5i
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7BW-00032R-JO; Wed, 28 Oct 2026 13:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xM7BQ-00031a-F0
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:11:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xM7BO-0003G8-0j
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:11:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvbMy1x54y5ebUNyNWCmiNy5ZTK0b6LiionCRRrk7x0=;
 b=V6Z0dX5iEUv5q9N+Ija3RYeTrRkjgyPKXNC+/wc07rWYEWylDm7Pa9tAEHk5dc7gcTgGkW
 vzaRg9N2yp4rNBsucuysPp5/O5z5aGNaohrUAXmMu4jb3t1FulpCwTakH1yS/JH+sUCZ+n
 d4OIInJ6dbIPNXyn+eSM0I5Y0FSGbDE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-0DnDnk_uOU2q-5ho8QICqg-1; Wed,
 28 Oct 2026 13:11:21 -0400
X-MC-Unique: 0DnDnk_uOU2q-5ho8QICqg-1
X-Mimecast-MFC-AGG-ID: 0DnDnk_uOU2q-5ho8QICqg_1793207475
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 985F01955E92; Wed, 28 Oct 2026 17:11:15 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.110])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 44E0B1800446; Wed, 28 Oct 2026 17:11:14 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, afaria@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH 2/2] iotests: Add loop-accept-ro-dev test
Date: Wed, 28 Oct 2026 18:10:57 +0100
Message-ID: <20261028171057.139326-3-kwolf@redhat.com>
In-Reply-To: <20261028171057.139326-1-kwolf@redhat.com>
References: <20261028171057.139326-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a test for the accept-read-only-device option of host_device.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/loop-accept-ro-dev   | 87 +++++++++++++++++++
 .../qemu-iotests/tests/loop-accept-ro-dev.out | 19 ++++
 2 files changed, 106 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/loop-accept-ro-dev
 create mode 100644 tests/qemu-iotests/tests/loop-accept-ro-dev.out

diff --git a/tests/qemu-iotests/tests/loop-accept-ro-dev b/tests/qemu-iotests/tests/loop-accept-ro-dev
new file mode 100755
index 00000000000..83ca67a0cf0
--- /dev/null
+++ b/tests/qemu-iotests/tests/loop-accept-ro-dev
@@ -0,0 +1,87 @@
+#!/usr/bin/env bash
+# group: quick
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Copyright Red Hat, Inc.
+#
+# Test the accept-read-only-device option on a loop device
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
+do_run_qemu()
+{
+    echo Testing: "$@"
+    $QEMU -nographic -qmp stdio -nodefaults "$@"
+    echo
+}
+
+run_qemu()
+{
+    echo -e '{"execute":"qmp_capabilities"}\n{"execute":"quit"}' |
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_qmp |
+        _filter_generated_node_ids | _filter_imgfmt |
+        _filter_actual_image_size | _filter_img_info
+}
+
+if ! sudo -n losetup &>/dev/null; then
+    _notrun "sudo losetup not available"
+fi
+
+if ! command -v blockdev >/dev/null 2>&1; then
+    _notrun "blockdev tool not available"
+fi
+
+echo
+echo "=== Start QEMU on a loop device after blockdev --setro ==="
+echo
+
+_make_test_img -f $IMGFMT 1M
+
+loopdev=$(sudo losetup --find --show "$TEST_IMG")
+if [ -z "$loopdev" ]; then
+    _fail
+fi
+
+sudo blockdev --setro "$loopdev"
+sudo chmod a+rw "$loopdev"
+
+run_qemu \
+    -blockdev host_device,node-name=disk,filename="$loopdev" \
+    -device virtio-blk,drive=disk
+
+run_qemu \
+    -blockdev host_device,node-name=disk,filename="$loopdev",accept-read-only-device=off \
+    -device virtio-blk,drive=disk
+
+run_qemu \
+    -blockdev host_device,node-name=disk,filename="$loopdev",accept-read-only-device=on \
+    -device virtio-blk,drive=disk
+
+# success, all done
+echo
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/loop-accept-ro-dev.out b/tests/qemu-iotests/tests/loop-accept-ro-dev.out
new file mode 100644
index 00000000000..dbf3de9fdf6
--- /dev/null
+++ b/tests/qemu-iotests/tests/loop-accept-ro-dev.out
@@ -0,0 +1,19 @@
+QA output created by loop-accept-ro-dev
+
+=== Start QEMU on a loop device after blockdev --setro ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+Testing: -blockdev host_device,node-name=disk,filename=/dev/loop1 -device virtio-blk,drive=disk
+QEMU_PROG: -blockdev host_device,node-name=disk,filename=/dev/loop1: The device is not writable: Permission denied
+
+Testing: -blockdev host_device,node-name=disk,filename=/dev/loop1,accept-read-only-device=off -device virtio-blk,drive=disk
+QEMU_PROG: -blockdev host_device,node-name=disk,filename=/dev/loop1,accept-read-only-device=off: The device is not writable: Permission denied
+
+Testing: -blockdev host_device,node-name=disk,filename=/dev/loop1,accept-read-only-device=on -device virtio-blk,drive=disk
+QMP_VERSION
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+
+
+*** done
-- 
2.56.0


