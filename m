Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A8ECCFA18
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Nov 2025 23:21:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHs0e-0005sQ-Ng; Sat, 08 Nov 2025 18:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs0O-0005mP-2a
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:06:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vHs0L-0001m5-Ue
 for qemu-devel@nongnu.org; Sat, 08 Nov 2025 18:05:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762643157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t1Hn5JAxT2XDEA1uwbAx5QKtwFdVZRbThx8XoBKz/Ts=;
 b=IkJWhBhbM0+9drYFyOVa3p0Kkzw4lcNOhkPf8AXDvMOIhptrdcplaHmu25QcH7+B6fXdwR
 UF4upPyXX1iEQvLSvnoBKW66UZ847pXdZhyd+MeyhWF8v2hfT/4MI20u6hAYMtVAsoq9I1
 Ji6RNAQT9NtuXAVJNvPYoqkJjcTtFpk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-15-QOOqL-A2P8eKSfC-QRnBnQ-1; Sat,
 08 Nov 2025 18:05:53 -0500
X-MC-Unique: QOOqL-A2P8eKSfC-QRnBnQ-1
X-Mimecast-MFC-AGG-ID: QOOqL-A2P8eKSfC-QRnBnQ_1762643152
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 93B411956096; Sat,  8 Nov 2025 23:05:52 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E660519560A7; Sat,  8 Nov 2025 23:05:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, berrange@redhat.com, kwolf@redhat.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 12/12] iotests: Add coverage of recent NBD qio deadlock fix
Date: Sat,  8 Nov 2025 16:59:33 -0600
Message-ID: <20251108230525.3169174-26-eblake@redhat.com>
In-Reply-To: <20251108230525.3169174-14-eblake@redhat.com>
References: <20251108230525.3169174-14-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Test that all images in a qcow2 chain using an NBD backing file can be
served by the same process.  Prior to the recent QIONetListener fixes,
this test would demonstrate deadlock.

The test borrows heavily from the original formula by "John Doe" in
the gitlab bug, but uses a Unix socket rather than TCP to avoid port
contention, and uses a full-blown QEMU rather than qemu-storage-daemon
since both programs were impacted.

The test starts out with the even simpler task of directly adding an
NBD client without qcow2 chain ('client'), which also provokes the
deadlock; but commenting out the 'Adding explicit NBD client' section
will still show deadlock when reaching the 'Adding wrapper image...'.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3169
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: split out vvfat changes, add an explicit client in addition to the
implicit one through qcow2
---
 tests/qemu-iotests/tests/nbd-in-qcow2-chain   | 94 +++++++++++++++++++
 .../qemu-iotests/tests/nbd-in-qcow2-chain.out | 75 +++++++++++++++
 2 files changed, 169 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-in-qcow2-chain
 create mode 100644 tests/qemu-iotests/tests/nbd-in-qcow2-chain.out

diff --git a/tests/qemu-iotests/tests/nbd-in-qcow2-chain b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
new file mode 100755
index 00000000000..455ddfa86fe
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-in-qcow2-chain
@@ -0,0 +1,94 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Test of opening both server and client NBD in a qcow2 backing chain
+#
+# Copyright (C) Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+# creator
+owner=eblake@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1    # failure is the default!
+
+_cleanup()
+{
+    _cleanup_qemu
+    _cleanup_test_img
+    rm -f "$SOCK_DIR/nbd"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+cd ..
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+. ./common.nbd
+
+_supported_fmt qcow2  # Hardcoded to qcow2 command line and QMP below
+_supported_proto file
+
+size=100M
+
+echo
+echo "=== Preparing base image ==="
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $size
+
+echo
+echo "=== Starting QEMU and exposing base image ==="
+
+_launch_qemu -machine q35
+h1=$QEMU_HANDLE
+_send_qemu_cmd $QEMU_HANDLE '{"execute": "qmp_capabilities"}' 'return'
+_send_qemu_cmd $QEMU_HANDLE '{"execute": "blockdev-add",
+  "arguments": {"node-name":"base", "driver":"qcow2",
+     "file":{"driver":"file", "filename":"'"$TEST_IMG.base"'"}}}' 'return'
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-start",
+  "arguments": {"addr":{"type":"unix",
+    "data":{"path":"'"$SOCK_DIR/nbd"'"}}}}' 'return'
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments": {"device":"base","name":"base"}}' 'return'
+
+echo
+echo "=== Adding explicit NBD client ==="
+
+_send_qemu_cmd $QEMU_HANDLE '{"execute": "blockdev-add",
+  "arguments": {"node-name":"client", "driver":"nbd",
+     "read-only":true, "export":"base",
+     "server":{"type":"unix", "path":"'"$SOCK_DIR/nbd"'"}}}' 'return'
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments": {"device":"client","name":"client"}}' 'return'
+
+echo
+echo "=== Creating wrapper image ==="
+
+_make_test_img -F raw -b "nbd+unix:///base?socket=$SOCK_DIR/nbd" $size
+
+echo
+echo "=== Adding wrapper image with implicit client from qcow2 file ==="
+
+_send_qemu_cmd $QEMU_HANDLE '{"execute": "blockdev-add",
+  "arguments": {"node-name":"wrap", "driver":"qcow2",
+     "file":{"driver":"file", "filename":"'"$TEST_IMG"'"}}}' 'return'
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments": {"device":"wrap","name":"wrap"}}' 'return'
+
+echo
+echo "=== Checking NBD server ==="
+
+$QEMU_NBD --list -k $SOCK_DIR/nbd
+
+echo
+echo "=== Cleaning up ==="
+
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"quit"}' ''
+
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/nbd-in-qcow2-chain.out b/tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
new file mode 100644
index 00000000000..b65cdaa4f25
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-in-qcow2-chain.out
@@ -0,0 +1,75 @@
+QA output created by nbd-in-qcow2-chain
+
+=== Preparing base image ===
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=104857600
+
+=== Starting QEMU and exposing base image ===
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "blockdev-add",
+  "arguments": {"node-name":"base", "driver":"IMGFMT",
+     "file":{"driver":"file", "filename":"TEST_DIR/t.IMGFMT.base"}}}
+{"return": {}}
+{"execute":"nbd-server-start",
+  "arguments": {"addr":{"type":"unix",
+    "data":{"path":"SOCK_DIR/nbd"}}}}
+{"return": {}}
+{"execute":"nbd-server-add",
+  "arguments": {"device":"base","name":"base"}}
+{"return": {}}
+
+=== Adding explicit NBD client ===
+{"execute": "blockdev-add",
+  "arguments": {"node-name":"client", "driver":"nbd",
+     "read-only":true, "export":"base",
+     "server":{"type":"unix", "path":"SOCK_DIR/nbd"}}}
+{"return": {}}
+{"execute":"nbd-server-add",
+  "arguments": {"device":"client","name":"client"}}
+{"return": {}}
+
+=== Creating wrapper image ===
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=104857600 backing_file=nbd+unix:///base?socket=SOCK_DIR/nbd backing_fmt=raw
+
+=== Adding wrapper image with implicit client from qcow2 file ===
+{"execute": "blockdev-add",
+  "arguments": {"node-name":"wrap", "driver":"IMGFMT",
+     "file":{"driver":"file", "filename":"TEST_DIR/t.IMGFMT"}}}
+{"return": {}}
+{"execute":"nbd-server-add",
+  "arguments": {"device":"wrap","name":"wrap"}}
+{"return": {}}
+
+=== Checking NBD server ===
+exports available: 3
+ export: 'base'
+  size:  104857600
+  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
+  min block: 1
+  opt block: 4096
+  max block: 33554432
+  transaction size: 64-bit
+  available meta contexts: 1
+   base:allocation
+ export: 'client'
+  size:  104857600
+  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
+  min block: 1
+  opt block: 4096
+  max block: 33554432
+  transaction size: 64-bit
+  available meta contexts: 1
+   base:allocation
+ export: 'wrap'
+  size:  104857600
+  flags: 0x158f ( readonly flush fua df multi cache block-status-payload )
+  min block: 1
+  opt block: 4096
+  max block: 33554432
+  transaction size: 64-bit
+  available meta contexts: 1
+   base:allocation
+
+=== Cleaning up ===
+{"execute":"quit"}
+*** done
-- 
2.51.1


