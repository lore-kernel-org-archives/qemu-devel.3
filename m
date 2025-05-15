Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88487C3ABD8
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 02:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFOMj-0007uQ-V9; Wed, 14 May 2025 22:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOM2-0007Io-MG
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1uFOLy-00048H-S0
 for qemu-devel@nongnu.org; Wed, 14 May 2025 22:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747276185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+xxTsJq4Klc2nl6rJpR6yyBxWo3fZ2eXlASsavZjSAM=;
 b=EHcqTauIOGfsu7wGecaQIYfID1qPRNkuqz/BCOKKBtKdWve2/LzHzzplPRHbhogF4zc5CH
 pMVuq1eetLO92SsXxRRlm8Ty1Xj5aoAmNVuqFHQErnYK0DFRxoUGa0QWuH0n8g73GcLQq7
 WXJdsQQrhZdmYRUI7FohHCClEryBWts=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-qFEr0uC3Ok2ON8T2Q3Zvlw-1; Wed,
 14 May 2025 22:29:43 -0400
X-MC-Unique: qFEr0uC3Ok2ON8T2Q3Zvlw-1
X-Mimecast-MFC-AGG-ID: qFEr0uC3Ok2ON8T2Q3Zvlw_1747276183
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06D0718004A7; Thu, 15 May 2025 02:29:43 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.66])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8A2541953B80; Thu, 15 May 2025 02:29:41 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core)
Subject: [PULL 13/14] tests: Add iotest mirror-sparse for recent patches
Date: Wed, 14 May 2025 21:28:56 -0500
Message-ID: <20250515022904.575509-29-eblake@redhat.com>
In-Reply-To: <20250515022904.575509-16-eblake@redhat.com>
References: <20250515022904.575509-16-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Prove that blockdev-mirror can now result in sparse raw destination
files, regardless of whether the source is raw or qcow2.  By making
this a separate test, it was possible to test effects of individual
patches for the various pieces that all have to work together for a
sparse mirror to be successful.

Note that ./check -file produces different job lengths than ./check
-qcow2 (the test uses a filter to normalize); that's because when
deciding how much of the image to be mirrored, the code looks at how
much of the source image was allocated (for qcow2, this is only the
written clusters; for raw, it is the entire file).  But the important
part is that the destination file ends up smaller than 3M, rather than
the 20M it used to be before this patch series.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20250509204341.3553601-28-eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/qemu-iotests/tests/mirror-sparse     | 125 +++++++
 tests/qemu-iotests/tests/mirror-sparse.out | 365 +++++++++++++++++++++
 2 files changed, 490 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/mirror-sparse
 create mode 100644 tests/qemu-iotests/tests/mirror-sparse.out

diff --git a/tests/qemu-iotests/tests/mirror-sparse b/tests/qemu-iotests/tests/mirror-sparse
new file mode 100755
index 00000000000..8c52a4e2448
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-sparse
@@ -0,0 +1,125 @@
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
+_launch_qemu \
+    -blockdev '{"driver":"file", "cache":{"direct":true, "no-flush":false},
+                "filename":"'"$TEST_IMG.base"'", "node-name":"src-file"}' \
+    -blockdev '{"driver":"'$IMGFMT'", "node-name":"src", "file":"src-file"}'
+h1=$QEMU_HANDLE
+_send_qemu_cmd $h1 '{"execute": "qmp_capabilities"}' 'return'
+
+# Check several combinations; most should result in a sparse destination;
+# the destination should only be fully allocated if pre-allocated
+# and not punching holes due to detect-zeroes
+# do_test creation discard zeroes result
+do_test() {
+    creation=$1
+    discard=$2
+    zeroes=$3
+    expected=$4
+
+echo
+echo "=== Testing creation=$creation discard=$discard zeroes=$zeroes ==="
+echo
+
+rm -f $TEST_IMG
+if test $creation = external; then
+    truncate --size=20M $TEST_IMG
+else
+    _send_qemu_cmd $h1 '{"execute": "blockdev-create", "arguments":
+          {"options": {"driver":"file", "filename":"'$TEST_IMG'",
+            "size":'$((20*1024*1024))', "preallocation":"'$creation'"},
+           "job-id":"job1"}}' 'concluded'
+    _send_qemu_cmd $h1 '{"execute": "job-dismiss", "arguments":
+          {"id": "job1"}}' 'return'
+fi
+_send_qemu_cmd $h1 '{"execute": "blockdev-add", "arguments":
+                     {"node-name": "dst", "driver":"file",
+                      "filename":"'$TEST_IMG'", "aio":"threads",
+                      "auto-read-only":true, "discard":"'$discard'",
+                      "detect-zeroes":"'$zeroes'"}}' 'return'
+_send_qemu_cmd $h1 '{"execute":"blockdev-mirror", "arguments":
+                     {"sync":"full", "device":"src", "target":"dst",
+                      "job-id":"job2"}}' 'return'
+_timed_wait_for $h1 '"ready"'
+_send_qemu_cmd $h1 '{"execute": "job-complete", "arguments":
+               {"id":"job2"}}' 'return' \
+                  | _filter_block_job_offset | _filter_block_job_len
+_send_qemu_cmd $h1 '{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}' 'return' \
+                  | _filter_block_job_offset | _filter_block_job_len
+$QEMU_IMG compare -U -f $IMGFMT -F raw $TEST_IMG.base $TEST_IMG
+result=$(disk_usage $TEST_IMG)
+if test $result -lt $((3*1024*1024)); then
+    actual=sparse
+elif test $result = $((20*1024*1024)); then
+    actual=full
+else
+    actual=unknown
+fi
+echo "Destination is $actual; expected $expected"
+}
+
+do_test external ignore off sparse
+do_test external unmap off sparse
+do_test external unmap unmap sparse
+do_test off ignore off sparse
+do_test off unmap off sparse
+do_test off unmap unmap sparse
+do_test full ignore off full
+do_test full unmap off sparse
+do_test full unmap unmap sparse
+
+_send_qemu_cmd $h1 '{"execute":"quit"}' ''
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/mirror-sparse.out b/tests/qemu-iotests/tests/mirror-sparse.out
new file mode 100644
index 00000000000..2103b891c3f
--- /dev/null
+++ b/tests/qemu-iotests/tests/mirror-sparse.out
@@ -0,0 +1,365 @@
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
+=== Testing creation=external discard=ignore zeroes=off ===
+
+{"execute": "blockdev-add", "arguments":
+                     {"node-name": "dst", "driver":"file",
+                      "filename":"TEST_DIR/t.IMGFMT", "aio":"threads",
+                      "auto-read-only":true, "discard":"ignore",
+                      "detect-zeroes":"off"}}
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
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+Destination is sparse; expected sparse
+
+=== Testing creation=external discard=unmap zeroes=off ===
+
+{"execute": "blockdev-add", "arguments":
+                     {"node-name": "dst", "driver":"file",
+                      "filename":"TEST_DIR/t.IMGFMT", "aio":"threads",
+                      "auto-read-only":true, "discard":"unmap",
+                      "detect-zeroes":"off"}}
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
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+Destination is sparse; expected sparse
+
+=== Testing creation=external discard=unmap zeroes=unmap ===
+
+{"execute": "blockdev-add", "arguments":
+                     {"node-name": "dst", "driver":"file",
+                      "filename":"TEST_DIR/t.IMGFMT", "aio":"threads",
+                      "auto-read-only":true, "discard":"unmap",
+                      "detect-zeroes":"unmap"}}
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
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+Destination is sparse; expected sparse
+
+=== Testing creation=off discard=ignore zeroes=off ===
+
+{"execute": "blockdev-create", "arguments":
+          {"options": {"driver":"file", "filename":"TEST_DIR/t.IMGFMT",
+            "size":20971520, "preallocation":"off"},
+           "job-id":"job1"}}
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
+                      "auto-read-only":true, "discard":"ignore",
+                      "detect-zeroes":"off"}}
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
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+Destination is sparse; expected sparse
+
+=== Testing creation=off discard=unmap zeroes=off ===
+
+{"execute": "blockdev-create", "arguments":
+          {"options": {"driver":"file", "filename":"TEST_DIR/t.IMGFMT",
+            "size":20971520, "preallocation":"off"},
+           "job-id":"job1"}}
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
+                      "auto-read-only":true, "discard":"unmap",
+                      "detect-zeroes":"off"}}
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
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+Destination is sparse; expected sparse
+
+=== Testing creation=off discard=unmap zeroes=unmap ===
+
+{"execute": "blockdev-create", "arguments":
+          {"options": {"driver":"file", "filename":"TEST_DIR/t.IMGFMT",
+            "size":20971520, "preallocation":"off"},
+           "job-id":"job1"}}
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
+                      "auto-read-only":true, "discard":"unmap",
+                      "detect-zeroes":"unmap"}}
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
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+Destination is sparse; expected sparse
+
+=== Testing creation=full discard=ignore zeroes=off ===
+
+{"execute": "blockdev-create", "arguments":
+          {"options": {"driver":"file", "filename":"TEST_DIR/t.IMGFMT",
+            "size":20971520, "preallocation":"full"},
+           "job-id":"job1"}}
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
+                      "auto-read-only":true, "discard":"ignore",
+                      "detect-zeroes":"off"}}
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
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+Destination is full; expected full
+
+=== Testing creation=full discard=unmap zeroes=off ===
+
+{"execute": "blockdev-create", "arguments":
+          {"options": {"driver":"file", "filename":"TEST_DIR/t.IMGFMT",
+            "size":20971520, "preallocation":"full"},
+           "job-id":"job1"}}
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
+                      "auto-read-only":true, "discard":"unmap",
+                      "detect-zeroes":"off"}}
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
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+Destination is sparse; expected sparse
+
+=== Testing creation=full discard=unmap zeroes=unmap ===
+
+{"execute": "blockdev-create", "arguments":
+          {"options": {"driver":"file", "filename":"TEST_DIR/t.IMGFMT",
+            "size":20971520, "preallocation":"full"},
+           "job-id":"job1"}}
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
+                      "auto-read-only":true, "discard":"unmap",
+                      "detect-zeroes":"unmap"}}
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
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments":
+                {"node-name": "dst"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job2", "len": LEN, "offset": OFFSET, "speed": 0, "type": "mirror"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "job2"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "job2"}}
+{"return": {}}
+Images are identical.
+Destination is sparse; expected sparse
+{"execute":"quit"}
+*** done
-- 
2.49.0


