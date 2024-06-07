Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FB68C27C53
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 00:29:30 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFf4Z-0000vq-Ng; Fri, 07 Jun 2024 15:16:23 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf4Y-0000lU-5S; Fri, 07 Jun 2024 15:16:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1sFf4V-0002tb-Tw; Fri, 07 Jun 2024 15:16:21 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8083B6E560;
 Fri,  7 Jun 2024 22:14:53 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id B71ECE275A;
 Fri,  7 Jun 2024 22:13:58 +0300 (MSK)
Received: (nullmailer pid 529428 invoked by uid 1000);
 Fri, 07 Jun 2024 19:13:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.1 51/71] iotests: test NBD+TLS+iothread
Date: Fri,  7 Jun 2024 22:13:32 +0300
Message-Id: <20240607191356.529336-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
References: <qemu-stable-9.0.1-20240607221321@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Blake <eblake@redhat.com>

Prevent regressions when using NBD with TLS in the presence of
iothreads, adding coverage the fix to qio channels made in the
previous patch.

The shell function pick_unused_port() was copied from
nbdkit.git/tests/functions.sh.in, where it had all authors from Red
Hat, agreeing to the resulting relicensing from 2-clause BSD to GPLv2.

CC: qemu-stable@nongnu.org
CC: "Richard W.M. Jones" <rjones@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-ID: <20240531180639.1392905-6-eblake@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
(cherry picked from commit a73c99378022ebb785481e84cfe1e81097546268)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/nbd-tls-iothread b/tests/qemu-iotests/tests/nbd-tls-iothread
new file mode 100755
index 0000000000..a2fb07206e
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-tls-iothread
@@ -0,0 +1,168 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Test of NBD+TLS+iothread
+#
+# Copyright (C) 2024 Red Hat, Inc.
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
+    rm -f "$dst_image"
+    tls_x509_cleanup
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+cd ..
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+. ./common.tls
+. ./common.nbd
+
+_supported_fmt qcow2  # Hardcoded to qcow2 command line and QMP below
+_supported_proto file
+
+# pick_unused_port
+#
+# Picks and returns an "unused" port, setting the global variable
+# $port.
+#
+# This is inherently racy, but we need it because qemu does not currently
+# permit NBD+TLS over a Unix domain socket
+pick_unused_port ()
+{
+    if ! (ss --version) >/dev/null 2>&1; then
+        _notrun "ss utility required, skipped this test"
+    fi
+
+    # Start at a random port to make it less likely that two parallel
+    # tests will conflict.
+    port=$(( 50000 + (RANDOM%15000) ))
+    while ss -ltn | grep -sqE ":$port\b"; do
+        ((port++))
+        if [ $port -eq 65000 ]; then port=50000; fi
+    done
+    echo picked unused port
+}
+
+tls_x509_init
+
+size=1G
+DST_IMG="$TEST_DIR/dst.qcow2"
+
+echo
+echo "== preparing TLS creds and spare port =="
+
+pick_unused_port
+tls_x509_create_root_ca "ca1"
+tls_x509_create_server "ca1" "server1"
+tls_x509_create_client "ca1" "client1"
+tls_obj_base=tls-creds-x509,id=tls0,verify-peer=true,dir="${tls_dir}"
+
+echo
+echo "== preparing image =="
+
+_make_test_img $size
+$QEMU_IMG create -f qcow2 "$DST_IMG" $size | _filter_img_create
+
+echo
+echo === Starting Src QEMU ===
+echo
+
+_launch_qemu -machine q35 \
+    -object iothread,id=iothread0 \
+    -object "${tls_obj_base}"/client1,endpoint=client \
+    -device '{"driver":"pcie-root-port", "id":"root0", "multifunction":true,
+              "bus":"pcie.0"}' \
+    -device '{"driver":"virtio-scsi-pci", "id":"virtio_scsi_pci0",
+              "bus":"root0", "iothread":"iothread0"}' \
+    -device '{"driver":"scsi-hd", "id":"image1", "drive":"drive_image1",
+              "bus":"virtio_scsi_pci0.0"}' \
+    -blockdev '{"driver":"file", "cache":{"direct":true, "no-flush":false},
+                "filename":"'"$TEST_IMG"'", "node-name":"drive_sys1"}' \
+    -blockdev '{"driver":"qcow2", "node-name":"drive_image1",
+                "file":"drive_sys1"}'
+h1=$QEMU_HANDLE
+_send_qemu_cmd $h1 '{"execute": "qmp_capabilities"}' 'return'
+
+echo
+echo === Starting Dst VM2 ===
+echo
+
+_launch_qemu -machine q35 \
+    -object iothread,id=iothread0 \
+    -object "${tls_obj_base}"/server1,endpoint=server \
+    -device '{"driver":"pcie-root-port", "id":"root0", "multifunction":true,
+              "bus":"pcie.0"}' \
+    -device '{"driver":"virtio-scsi-pci", "id":"virtio_scsi_pci0",
+              "bus":"root0", "iothread":"iothread0"}' \
+    -device '{"driver":"scsi-hd", "id":"image1", "drive":"drive_image1",
+              "bus":"virtio_scsi_pci0.0"}' \
+    -blockdev '{"driver":"file", "cache":{"direct":true, "no-flush":false},
+                "filename":"'"$DST_IMG"'", "node-name":"drive_sys1"}' \
+    -blockdev '{"driver":"qcow2", "node-name":"drive_image1",
+                "file":"drive_sys1"}' \
+    -incoming defer
+h2=$QEMU_HANDLE
+_send_qemu_cmd $h2 '{"execute": "qmp_capabilities"}' 'return'
+
+echo
+echo === Dst VM: Enable NBD server for incoming storage migration ===
+echo
+
+_send_qemu_cmd $h2 '{"execute": "nbd-server-start", "arguments":
+    {"addr": {"type": "inet", "data": {"host": "127.0.0.1", "port": "'$port'"}},
+              "tls-creds": "tls0"}}' '{"return": {}}' | sed "s/\"$port\"/PORT/g"
+_send_qemu_cmd $h2 '{"execute": "block-export-add", "arguments":
+    {"node-name": "drive_image1", "type": "nbd", "writable": true,
+      "id": "drive_image1"}}' '{"return": {}}'
+
+echo
+echo === Src VM: Mirror to dst NBD for outgoing storage migration ===
+echo
+
+_send_qemu_cmd $h1 '{"execute": "blockdev-add", "arguments":
+    {"node-name": "mirror", "driver": "nbd",
+     "server": {"type": "inet", "host": "127.0.0.1", "port": "'$port'"},
+     "export": "drive_image1", "tls-creds": "tls0",
+     "tls-hostname": "127.0.0.1"}}' '{"return": {}}' | sed "s/\"$port\"/PORT/g"
+_send_qemu_cmd $h1 '{"execute": "blockdev-mirror", "arguments":
+    {"sync": "full", "device": "drive_image1", "target": "mirror",
+     "job-id": "drive_image1_53"}}' '{"return": {}}'
+_timed_wait_for $h1 '"ready"'
+
+echo
+echo === Cleaning up ===
+echo
+
+_send_qemu_cmd $h1 '{"execute":"quit"}' ''
+_send_qemu_cmd $h2 '{"execute":"quit"}' ''
+
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/nbd-tls-iothread.out b/tests/qemu-iotests/tests/nbd-tls-iothread.out
new file mode 100644
index 0000000000..1d83d4f903
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-tls-iothread.out
@@ -0,0 +1,54 @@
+QA output created by nbd-tls-iothread
+
+== preparing TLS creds and spare port ==
+picked unused port
+Generating a self signed certificate...
+Generating a signed certificate...
+Generating a signed certificate...
+
+== preparing image ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
+Formatting 'TEST_DIR/dst.IMGFMT', fmt=IMGFMT size=1073741824
+
+=== Starting Src QEMU ===
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+
+=== Starting Dst VM2 ===
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+
+=== Dst VM: Enable NBD server for incoming storage migration ===
+
+{"execute": "nbd-server-start", "arguments":
+    {"addr": {"type": "inet", "data": {"host": "127.0.0.1", "port": PORT}},
+              "tls-creds": "tls0"}}
+{"return": {}}
+{"execute": "block-export-add", "arguments":
+    {"node-name": "drive_image1", "type": "nbd", "writable": true,
+      "id": "drive_image1"}}
+{"return": {}}
+
+=== Src VM: Mirror to dst NBD for outgoing storage migration ===
+
+{"execute": "blockdev-add", "arguments":
+    {"node-name": "mirror", "driver": "nbd",
+     "server": {"type": "inet", "host": "127.0.0.1", "port": PORT},
+     "export": "drive_image1", "tls-creds": "tls0",
+     "tls-hostname": "127.0.0.1"}}
+{"return": {}}
+{"execute": "blockdev-mirror", "arguments":
+    {"sync": "full", "device": "drive_image1", "target": "mirror",
+     "job-id": "drive_image1_53"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "drive_image1_53"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "drive_image1_53"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "drive_image1_53"}}
+
+=== Cleaning up ===
+
+{"execute":"quit"}
+{"execute":"quit"}
+*** done
-- 
2.39.2


