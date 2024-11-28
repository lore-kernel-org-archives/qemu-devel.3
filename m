Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564E5D70DE8
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 18:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGjQZ-000743-1O; Thu, 28 Nov 2024 13:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQL-0006yM-QV; Thu, 28 Nov 2024 13:39:34 -0500
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1tGjQI-00060O-Fq; Thu, 28 Nov 2024 13:39:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-ID:Date:Subject:From:
 Content-Type; bh=UhBwOVLNTmzdrnNMePKQwoRxWaPb6x4aFbZNwX4XSQo=; b=N2JXXUvkaI4W
 W84aPRlNwFC/d6pV21NNAbAqeCrfxIa1PEOsJvX+uLntvYACV88MtkqHJ1YM4yuLra/uEafcrhoIQ
 BdOv7nL0kNkMusHOKyqVfK0nIDI/55tPKablsm6iORaOAWF66OFbVDY1azx93e1WvcArPK0POma0r
 pKuBTqIvW6NXZFd/Yf6QhySdAOHASEU1hVnz68/kGB0RGPMkAurYA7tExloLB0Ru07Vq4MfGSNu7s
 tkYSJRHs75Wrf3YM7/+DtPoWbCzRNUcWpaQ896QnXonV+7iETCA7vshvMY4Syk9T6oHkyZBbSDVoz
 do729TMeenZb/2biLS5zvQ==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1tGjPp-00E2DN-1Z;
 Thu, 28 Nov 2024 19:39:11 +0100
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 6/6] iotests: add preallocate filter checks
Date: Thu, 28 Nov 2024 19:25:53 +0100
Message-ID: <20241128183911.837699-7-den@openvz.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241128183911.837699-1-den@openvz.org>
References: <20241128183911.837699-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

This test summaries the cases faced inside Virtuozzo with the
preallocation filter worth to be added to unit tests:

  1. Launch a VM whose block graph has preallocate filter node and
     migrate it locally into a file.
  2. Same, but make sure preallocate filter is activated by performing a
     write op to it beyond the current disk length (which is zero).
  3. Add testcase which would perform write operation to VM disk to make
     sure preallocation filter is active, and then run 'blockdev-snapshot'
     command to turn another image (also with preallocation) into an
     external snapshot and make it an active disk.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 tests/qemu-iotests/tests/prealloc-checks     | 222 +++++++++++++++++++
 tests/qemu-iotests/tests/prealloc-checks.out |  81 +++++++
 2 files changed, 303 insertions(+)
 create mode 100644 tests/qemu-iotests/tests/prealloc-checks
 create mode 100644 tests/qemu-iotests/tests/prealloc-checks.out

diff --git a/tests/qemu-iotests/tests/prealloc-checks b/tests/qemu-iotests/=
tests/prealloc-checks
new file mode 100644
index 0000000000..fc55353cb9
--- /dev/null
+++ b/tests/qemu-iotests/tests/prealloc-checks
@@ -0,0 +1,222 @@
+#!/usr/bin/env bash
+# group: rw
+#
+# Checks for preallocate filter.
+#
+# Copyright (c) 2024 Virtuozzo International GmbH. All rights reserved.
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
+owner=3Dandrey.drobyshev@virtuozzo.com
+
+seq=3D`basename $0`
+echo "QA output created by $seq"
+
+status=3D1 # failure is the default!
+
+_cleanup()
+{
+    _cleanup_qemu
+    rm -f $SOCK_DIR/nbd.sock
+    rm -f $TEST_IMG.snap
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ../common.rc
+. ../common.filter
+. ../common.qemu
+
+_supported_fmt qcow2
+
+_recreate_test_img()
+{
+    local size=3D"1M"
+    local imgopts=3D"cluster_size=3D$size,extended_l2=3Don,lazy_refcounts=
=3Don"
+    local image=3D"$TEST_IMG"
+
+    if test -n "$1" ; then
+        image=3D"$1"
+    fi
+
+    rm -f $image
+    TEST_IMG=3D$image _make_test_img -o "$imgopts" $size
+}
+
+blkopts=3D"node-name=3Ddisk,driver=3Dqcow2,file.driver=3Dpreallocate,"
+blkopts+=3D"file.node-name=3Dprealloc,file.file.driver=3Dfile,"
+blkopts+=3D"file.file.filename=3D$TEST_IMG,file.file.node-name=3Dstorage"
+
+#
+# 1. Launch a VM so that its block graph contains preallocate filter node,
+# and perform its local migration to a file.  That is similar to doing
+# "virsh save VM /path/to/vmsave".
+#
+
+echo
+echo =3D=3D=3D 1. Migration to a local file =3D=3D=3D
+echo
+
+echo "# Create image and start VM with preallocate filter:"
+echo
+_recreate_test_img
+qemu_comm_method=3D"monitor" _launch_qemu -blockdev "$blkopts"
+handle=3D$QEMU_HANDLE
+_send_qemu_cmd $handle "" "(qemu)"
+
+echo
+echo "# Migrate VM to a local file (/dev/null):"
+echo
+_send_qemu_cmd $handle "migrate \"exec: cat > '/dev/null'\"" "(qemu)"
+
+echo
+echo "# Exit VM:"
+echo
+_send_qemu_cmd $handle "quit" ""
+wait=3Dyes _cleanup_qemu
+
+#
+# 2. Same as 1st, but this time we make sure that preallocate filter is
+# actually active. To do that we perform a write op beyond current length
+# (which is 0 as the image's just created).  Then migrate VM to a local
+# file (/dev/null).
+#
+
+echo
+echo =3D=3D=3D 2. Migration to a local file after a write operation =3D=3D=
=3D
+echo
+
+echo "# Create image and start VM with preallocate filter:"
+echo
+_recreate_test_img
+qemu_comm_method=3D"monitor" _launch_qemu -blockdev "$blkopts"
+handle=3D$QEMU_HANDLE
+_send_qemu_cmd $handle "" "(qemu)"
+
+echo
+echo "# Perform write op to the image to activate preallocate filter:"
+echo
+_send_qemu_cmd $handle 'qemu-io disk "write -P 0xff 0 1M"' "1 MiB"
+
+echo
+echo "# Migrate VM to a local file (/dev/null):"
+echo
+_send_qemu_cmd $handle "migrate \"exec: cat > '/dev/null'\"" "(qemu)"
+
+echo
+echo "# Exit VM:"
+echo
+_send_qemu_cmd $handle "quit" ""
+wait=3Dyes _cleanup_qemu
+
+#
+# 3. Add another overlay image (with preallocation filter as well), launch
+# VM, export its disk via nbd to perform a write operation and activate the
+# preallocation filter, and then run 'blockdev-snapshot' to turn the overl=
ay
+# image into an external snapshot of the disk.
+#
+
+echo
+echo =3D=3D=3D 3. Taking external snapshot after a write operation =3D=3D=
=3D
+echo
+
+snapblkopts=3D"node-name=3Dsnap,driver=3Dqcow2,file.driver=3Dpreallocate,"
+snapblkopts+=3D"file.node-name=3Dsnap-prealloc,file.file.driver=3Dfile,"
+snapblkopts+=3D"file.file.filename=3D$TEST_IMG.snap,"
+snapblkopts+=3D"file.file.node-name=3Dsnap-storage"
+
+echo "# Create disk and snapshot images and start VM with preallocate filt=
er:"
+echo
+_recreate_test_img
+_recreate_test_img $TEST_IMG.snap
+
+qemu_comm_method=3D"qmp" qmp_pretty=3D \
+    _launch_qemu -blockdev "$snapblkopts" -blockdev "$blkopts"
+handle=3D$QEMU_HANDLE
+_send_qemu_cmd $handle "{ 'execute': 'qmp_capabilities' }" "return"
+
+silent=3Dyes
+
+echo
+echo "# Start nbd server:"
+echo
+_send_qemu_cmd $handle \
+    "{ 'execute': 'nbd-server-start',
+       'arguments': { 'addr': { 'type': 'unix',
+                                'data': { 'path': '$SOCK_DIR/nbd.sock' }}}=
}"
+_send_qemu_cmd $handle "" "return"
+
+echo
+echo "# Export 'disk' node via nbd server:"
+echo
+_send_qemu_cmd $handle \
+    "{ 'execute': 'block-export-add',
+       'arguments': { 'type': 'nbd', 'node-name': 'disk', 'id': 'nbdexp',
+                      'name': 'nbdexp', 'writable': true }}"
+_send_qemu_cmd $handle "" "return"
+
+echo
+echo "# Perform write op to the nbd-exported disk:"
+echo
+silent=3D
+$QEMU_IO_PROG -f raw -c "write -P 0xff 0 1M" \
+    "nbd+unix:///nbdexp?socket=3D$SOCK_DIR/nbd.sock" 2>&1 \
+    | _filter_qemu_io | _filter_nbd
+
+echo
+echo "# Delete nbd export:"
+echo
+silent=3Dyes
+_send_qemu_cmd $handle \
+    "{ 'execute': 'block-export-del', 'arguments': { 'id': 'nbdexp' }}"
+_send_qemu_cmd $handle "" "return"
+
+echo
+echo "# Stop nbd server:"
+echo
+_send_qemu_cmd $handle \
+    "{ 'execute': 'nbd-server-stop' }"
+_send_qemu_cmd $handle "" "return"
+
+echo
+echo "# Turn 'snap' node into the external snapshot of 'disk' node:"
+echo
+silent=3D
+_send_qemu_cmd $handle \
+    "{ 'execute': 'blockdev-snapshot',
+       'arguments': { 'node': 'disk', 'overlay': 'snap' }}"
+_send_qemu_cmd $handle "" "return"
+
+echo
+echo "# Check block graph:"
+echo
+_send_qemu_cmd $handle \
+    "{ 'execute': 'x-debug-query-block-graph' }"
+_send_qemu_cmd $handle "" "return"
+
+echo
+echo "# Exit VM:"
+echo
+qmp_pretty=3D
+silent=3Dyes
+_send_qemu_cmd $handle "{ 'execute': 'quit' }" "qmp-quit"
+wait=3Dyes _cleanup_qemu
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/tests/prealloc-checks.out b/tests/qemu-iote=
sts/tests/prealloc-checks.out
new file mode 100644
index 0000000000..10b5f8fa8e
--- /dev/null
+++ b/tests/qemu-iotests/tests/prealloc-checks.out
@@ -0,0 +1,81 @@
+QA output created by prealloc-checks
+
+=3D=3D=3D 1. Migration to a local file =3D=3D=3D
+
+# Create image and start VM with preallocate filter:
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu)
+
+# Migrate VM to a local file (/dev/null):
+
+(qemu) migrate "exec: cat > '/dev/null'"
+
+# Exit VM:
+
+(qemu) quit
+
+=3D=3D=3D 2. Migration to a local file after a write operation =3D=3D=3D
+
+# Create image and start VM with preallocate filter:
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu)
+
+# Perform write op to the image to activate preallocate filter:
+
+(qemu) qemu-io disk "write -P 0xff 0 1M"
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Migrate VM to a local file (/dev/null):
+
+(qemu) migrate "exec: cat > '/dev/null'"
+
+# Exit VM:
+
+(qemu) quit
+
+=3D=3D=3D 3. Taking external snapshot after a write operation =3D=3D=3D
+
+# Create disk and snapshot images and start VM with preallocate filter:
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576
+Formatting 'TEST_DIR/t.IMGFMT.snap', fmt=3DIMGFMT size=3D1048576
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+
+# Start nbd server:
+
+
+# Export 'disk' node via nbd server:
+
+
+# Perform write op to the nbd-exported disk:
+
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+# Delete nbd export:
+
+
+# Stop nbd server:
+
+
+# Turn 'snap' node into the external snapshot of 'disk' node:
+
+{ 'execute': 'blockdev-snapshot',
+       'arguments': { 'node': 'disk', 'overlay': 'snap' }}
+{"return": {}}
+
+# Check block graph:
+
+{ 'execute': 'x-debug-query-block-graph' }
+{"return": {"edges": [{"name": "file", "parent": 4, "shared-perm": ["write=
-unchanged", "consistent-read"], "perm": ["consistent-read"], "child": 6}, =
{"name": "file", "parent": 6, "shared-perm": ["write-unchanged", "consisten=
t-read"], "perm": ["consistent-read"], "child": 5}, {"name": "file", "paren=
t": 3, "shared-perm": ["write-unchanged", "consistent-read"], "perm": ["res=
ize", "write", "consistent-read"], "child": 2}, {"name": "backing", "parent=
": 3, "shared-perm": ["resize", "write-unchanged", "write", "consistent-rea=
d"], "perm": [], "child": 4}, {"name": "file", "parent": 2, "shared-perm": =
["write-unchanged", "consistent-read"], "perm": ["resize", "write", "consis=
tent-read"], "child": 1}], "nodes": [{"name": "disk", "type": "block-driver=
", "id": 4}, {"name": "prealloc", "type": "block-driver", "id": 6}, {"name"=
: "storage", "type": "block-driver", "id": 5}, {"name": "snap", "type": "bl=
ock-driver", "id": 3}, {"name": "snap-prealloc", "type": "block-driver", "i=
d": 2}, {"name": "snap-storage", "type": "block-driver", "id": 1}]}}
+
+# Exit VM:
+
+{"return": {}}
+*** done
--=20
2.45.2


