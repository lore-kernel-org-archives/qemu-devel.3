Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ACFC369A6
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 01:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u32ss-0006Zm-Rv; Thu, 10 Apr 2025 21:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32sI-0006TI-Dl
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:08:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u32sA-0004K7-0i
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 21:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744333677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IlZtSfeqvD+H2+2X37MVdXiNoRPyD0YoBpqxsczyCcI=;
 b=HsABdRVjYWZv8z7das32ZxwDjtXY6czIEoD8EG3w8xiX0iBo2OHzXtRxYU6mbQaox0Vf5f
 wGHjjUtGzuz17aNlhLByBaNOczBJe2thbT8FM4LH9/uVi/mfCrp8b5aqcrhnHiAiFkDnZX
 1rKgtqbFDWbpb46TND7DrjH9MWbMWR0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-ytXlVO3GPPuRTqiSzWw3GQ-1; Thu,
 10 Apr 2025 21:07:53 -0400
X-MC-Unique: ytXlVO3GPPuRTqiSzWw3GQ-1
X-Mimecast-MFC-AGG-ID: ytXlVO3GPPuRTqiSzWw3GQ_1744333673
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF3B3180882E; Fri, 11 Apr 2025 01:07:52 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.21])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF4A81801A69; Fri, 11 Apr 2025 01:07:51 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PATCH 6/6] tests: Add iotest mirror-sparse for recent patches
Date: Thu, 10 Apr 2025 20:04:56 -0500
Message-ID: <20250411010732.358817-14-eblake@redhat.com>
In-Reply-To: <20250411010732.358817-8-eblake@redhat.com>
References: <20250411010732.358817-8-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.593,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Prove that blockdev-mirror can now result in sparse destination files.
By making this a separate test, it was possible to test effects of
individual patches for the various pieces that all have to work
together for a sparse mirror to be successful.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/tests/mirror-sparse     | 100 ++++++++++++++
 tests/qemu-iotests/tests/mirror-sparse.out | 153 +++++++++++++++++++++
 2 files changed, 253 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/mirror-sparse
 create mode 100644 tests/qemu-iotests/tests/mirror-sparse.out

diff --git a/tests/qemu-iotests/tests/mirror-sparse b/tests/qemu-iotests/tests/mirror-sparse
new file mode 100755
index 00000000000..4251dea7531
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-sparse
@@ -0,0 +1,100 @@
+#!/usr/bin/env bash
+# group: rw auto quick
+#
+# Test blockdev-mirror with raw sparse destination
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
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1 # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    _cleanup_qemu
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+cd ..
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2 raw  # Format of the source. dst is always raw file
+_supported_proto file
+_supported_os Linux
+
+echo
+echo "=== Initial image setup ==="
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img 20M
+$QEMU_IO -c 'w 8M 2M' -f $IMGFMT "$TEST_IMG.base" | _filter_qemu_io
+
+_launch_qemu -machine q35 \
+    -blockdev '{"driver":"file", "cache":{"direct":true, "no-flush":false},
+                "filename":"'"$TEST_IMG.base"'", "node-name":"src-file"}' \
+    -blockdev '{"driver":"'$IMGFMT'", "node-name":"src", "file":"src-file"}'
+h1=$QEMU_HANDLE
+_send_qemu_cmd $h1 '{"execute": "qmp_capabilities"}' 'return'
+
+# Each of these combinations should result in a sparse destination;
+# the destination should only be fully allocated if pre-allocated
+for creation in external blockdev-create; do
+for discard in ignore unmap; do
+
+echo
+echo "=== Destination with $creation creation and discard=$discard ==="
+echo
+
+rm -f $TEST_IMG
+if test $creation = external; then
+    truncate --size=20M $TEST_IMG
+else
+    _send_qemu_cmd $h1 '{"execute": "blockdev-create", "arguments":
+          {"options": {"driver":"file", "filename":"'$TEST_IMG'",
+          "size":'$((20*1024*1024))'}, "job-id":"job1"}}' 'concluded'
+    _send_qemu_cmd $h1 '{"execute": "job-dismiss", "arguments":
+          {"id": "job1"}}' 'return'
+fi
+_send_qemu_cmd $h1 '{"execute": "blockdev-add", "arguments":
+                     {"node-name": "dst", "driver":"file",
+                      "filename":"'$TEST_IMG'", "aio":"threads",
+                      "auto-read-only":true, "discard":"'$discard'"}}' 'return'
+_send_qemu_cmd $h1 '{"execute":"blockdev-mirror", "arguments":
+                     {"sync":"full", "device":"src", "target":"dst",
+                      "job-id":"job2"}}' 'return'
+_timed_wait_for $h1 '"ready"'
+_send_qemu_cmd $h1 '{"execute": "job-complete", "arguments":
+               {"id":"job2"}}' 'return'
+_send_qemu_cmd $h1 '{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}' 'return'
+$QEMU_IMG compare -f $IMGFMT -F raw $TEST_IMG.base $TEST_IMG
+$QEMU_IMG info -f raw $TEST_IMG | grep '^disk size:'
+
+done
+done
+
+_send_qemu_cmd $h1 '{"execute":"quit"}' ''
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/mirror-sparse.out b/tests/qemu-iotests/tests/mirror-sparse.out
new file mode 100644
index 00000000000..16eb041841f
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-sparse.out
@@ -0,0 +1,153 @@
+QA output created by mirror-sparse
+
+=== Initial image setup ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=20971520
+wrote 2097152/2097152 bytes at offset 8388608
+2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{"execute": "qmp_capabilities"}
+{"return": {}}
+
+=== Destination with external creation and discard=ignore ===
+
+{"execute": "blockdev-add", "arguments":
+                     {"node-name": "dst", "driver":"file",
+                      "filename":"TEST_DIR/t.IMGFMT", "aio":"threads",
+                      "auto-read-only":true, "discard":"ignore"}}
+{"return": {}}
+{"execute":"blockdev-mirror", "arguments":
+                     {"sync":"full", "device":"src", "target":"dst",
+                      "job-id":"job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job2"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job2"}}
+{"execute": "job-complete", "arguments":
+               {"id":"job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": 20971520, "offset": 20971520, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": 20971520, "offset": 20971520, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+disk size: 2.06 MiB
+
+=== Destination with external creation and discard=unmap ===
+
+{"execute": "blockdev-add", "arguments":
+                     {"node-name": "dst", "driver":"file",
+                      "filename":"TEST_DIR/t.IMGFMT", "aio":"threads",
+                      "auto-read-only":true, "discard":"unmap"}}
+{"return": {}}
+{"execute":"blockdev-mirror", "arguments":
+                     {"sync":"full", "device":"src", "target":"dst",
+                      "job-id":"job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job2"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job2"}}
+{"execute": "job-complete", "arguments":
+               {"id":"job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": 20971520, "offset": 20971520, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": 20971520, "offset": 20971520, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+disk size: 2.06 MiB
+
+=== Destination with blockdev-create creation and discard=ignore ===
+
+{"execute": "blockdev-create", "arguments":
+          {"options": {"driver":"file", "filename":"TEST_DIR/t.IMGFMT",
+          "size":20971520}, "job-id":"job1"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job1"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job1"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job1"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job1"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job1"}}
+{"execute": "job-dismiss", "arguments":
+          {"id": "job1"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job1"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments":
+                     {"node-name": "dst", "driver":"file",
+                      "filename":"TEST_DIR/t.IMGFMT", "aio":"threads",
+                      "auto-read-only":true, "discard":"ignore"}}
+{"return": {}}
+{"execute":"blockdev-mirror", "arguments":
+                     {"sync":"full", "device":"src", "target":"dst",
+                      "job-id":"job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job2"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job2"}}
+{"execute": "job-complete", "arguments":
+               {"id":"job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": 20971520, "offset": 20971520, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": 20971520, "offset": 20971520, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+disk size: 2.06 MiB
+
+=== Destination with blockdev-create creation and discard=unmap ===
+
+{"execute": "blockdev-create", "arguments":
+          {"options": {"driver":"file", "filename":"TEST_DIR/t.IMGFMT",
+          "size":20971520}, "job-id":"job1"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job1"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job1"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job1"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job1"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job1"}}
+{"execute": "job-dismiss", "arguments":
+          {"id": "job1"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job1"}}
+{"return": {}}
+{"execute": "blockdev-add", "arguments":
+                     {"node-name": "dst", "driver":"file",
+                      "filename":"TEST_DIR/t.IMGFMT", "aio":"threads",
+                      "auto-read-only":true, "discard":"unmap"}}
+{"return": {}}
+{"execute":"blockdev-mirror", "arguments":
+                     {"sync":"full", "device":"src", "target":"dst",
+                      "job-id":"job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "job2"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job2"}}
+{"execute": "job-complete", "arguments":
+               {"id":"job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": 20971520, "offset": 20971520, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": 20971520, "offset": 20971520, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+disk size: 2.06 MiB
+{"execute":"quit"}
+*** done
-- 
2.49.0


