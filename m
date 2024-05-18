Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C391C04FFE
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2024 02:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s8ABy-0006wh-Io; Fri, 17 May 2024 22:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1s8ABw-0006vm-MJ
 for qemu-devel@nongnu.org; Fri, 17 May 2024 22:53:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1s8ABu-0006vg-24
 for qemu-devel@nongnu.org; Fri, 17 May 2024 22:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716000777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PSq2EsDgZdX/BNAEDBan3vaqCqjQwFUzDhXEiz0oqeE=;
 b=jR0YUaG4Z0k+et7vmu38HEXhlqA2j/O/Twa5HlRUPLRJdnkzQ3CwS1Bwp48IGsAx/szbmJ
 V5WpqtsRBkQY3D+yaBhxM4BlXh7lndDQQPKCBx2KpqSJ3jdPWZ2sXG0qduKl0Ds98Ilhqt
 SV+CTo1qTcCkehmWftr9UQFkxdxegHI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-uX5HXs1IOVayvW3ycnFrwA-1; Fri, 17 May 2024 22:52:55 -0400
X-MC-Unique: uX5HXs1IOVayvW3ycnFrwA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 101AB184882D;
 Sat, 18 May 2024 02:52:55 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.57])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97556402D8D;
 Sat, 18 May 2024 02:52:53 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, berrange@redhat.com,
 qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 2/2] iotests: test NBD+TLS+iothread
Date: Fri, 17 May 2024 21:50:15 -0500
Message-ID: <20240518025246.791593-6-eblake@redhat.com>
In-Reply-To: <20240518025246.791593-4-eblake@redhat.com>
References: <20240518025246.791593-4-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
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

Prevent regressions when using NBD with TLS in the presence of
iothreads, adding coverage the fix to qio channels made in the
previous patch.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/tests/nbd-tls-iothread     | 170 ++++++++++++++++++
 tests/qemu-iotests/tests/nbd-tls-iothread.out |  54 ++++++
 2 files changed, 224 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-tls-iothread
 create mode 100644 tests/qemu-iotests/tests/nbd-tls-iothread.out

diff --git a/tests/qemu-iotests/tests/nbd-tls-iothread b/tests/qemu-iotests/tests/nbd-tls-iothread
new file mode 100755
index 00000000000..a737224a90e
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-tls-iothread
@@ -0,0 +1,170 @@
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
+_require_command QEMU_NBD
+
+# pick_unused_port
+# Copied from nbdkit/tests/functions.sh.in with compatible 2-clause BSD license
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
+$QEMU_IMG create -f qcow2 "$DST_IMG" $size
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
index 00000000000..b5e12dcbe7a
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
+Formatting '/home/eblake/qemu/build/tests/qemu-iotests/scratch/qcow2-file-nbd-tls-iothread/dst.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1073741824 lazy_refcounts=off refcount_bits=16
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
2.45.0


