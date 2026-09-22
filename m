Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4495C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x975T-00060O-13; Tue, 22 Sep 2026 16:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972N-0001KK-7z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972H-0000an-2J
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vnb3vnzFH71VWXNcWg//rZ8ayuAg8z7/dRTP9L3L/7U=;
 b=P9nMdYEA+qsNoc5v6XpVuMp612jgAh3kLod+WJh3/lyi2cs821Sp+DF1ln19vhmJZz86rx
 hppr00gwIQOLBbXWx3vG9//6dLyrgci0x9ey91QbQTxK8wjHzv8Q8LPl9T70dnh/txjn9c
 FKC0h0nJz9Ogl4uKjjrxGwOmTN8wRE0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-Q3YxwCgYPe6DP-Bzzz0-1Q-1; Tue,
 22 Sep 2026 16:24:12 -0400
X-MC-Unique: Q3YxwCgYPe6DP-Bzzz0-1Q-1
X-Mimecast-MFC-AGG-ID: Q3YxwCgYPe6DP-Bzzz0-1Q_1790108651
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4FB8D18009FC; Tue, 22 Sep 2026 20:24:11 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 955C91956095; Tue, 22 Sep 2026 20:24:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:31 +0400
Subject: [PATCH 84/88] qemu-iotests/051: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-84-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=99142;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FMO7H+RAdAXwQlf6GIRCKS7KDhEy80nAoYeixjwoToI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuK0DzjgCFr/yrO2HwFL2mrEQxfU1KMeTAB18
 RYCPNcLcRmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLitAAKCRDa6OEJdZac
 5QYZD/4lLgK+UhIqnsDi4e4flz+7v5MUQ0jFHR/3WLGB8rvjpReRs9w50Kh6koCYFWNrcv+9D4k
 xyY82hlA7yW2QP02QlWO17m8c4oyvOPF4Nw3RhIwhli5fJy3y3SxJX/7eoXvOt1nnbZWbFjPzHU
 qXIhQ2jhFNX++fQVgy79FoUVxMGwSOiFXVoqeHY9ETKE92tjE/5PqMVL4SMwugwt1Nl4XFDbIEU
 YsZO21beQPlinUVROosG6LhGzfXWCWc8aoBua72FbzQeTgqA5UPU9m3kdi8fgFoxlxUcUDcX9TO
 sQgA+p06y7HxLrDE9NEC7FsqbOHTtszjngNfvHeC4h1e5tM8jdYXdxMFLXSGzFy8hyqDhYyKTqR
 74PH4NLqCgZIdq4o/WUtv9G6I5CsJLWa0XhTY3JH8EznLfFXdw2igmXUcWxrpiSxsdh0VvPb/31
 fFm55ZxoIz87/EB6RKGbmtLoPySuMQe2c20Nn1JJyb/M4oAkE7U9bxxptoR8brjurS25Z0NYxoY
 KJnj3SXtZ5W1Sdjq+auquTFemdWHWT0TaNq6SRSBV1GNH7w3KulEfsrBlsHXCYJxO29+LP672Nx
 PRmw5EOqQNnTN5Icj8cnQXe2DrMQZ/y7VAr4YyzxQdHzVx2UK/DUHY6HZf0zKgkG5VfY5h/cHeU
 biJP9E3B8VX5JtQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Replace pipe-based HMP monitor with QMP. Convert info block, qemu-io,
and commit commands to their QMP equivalents. Use existing filter
helpers (_filter_qmp, _filter_qmp_empty_return, _filter_actual_image_size)
instead of custom Python filters.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/051        |  75 ++++++----
 tests/qemu-iotests/051.out    | 241 ++++++++++++--------------------
 tests/qemu-iotests/051.pc.out | 311 ++++++++++++++++--------------------------
 3 files changed, 258 insertions(+), 369 deletions(-)

diff --git a/tests/qemu-iotests/051 b/tests/qemu-iotests/051
index a722c0c1bc8f..fd9074f978bc 100755
--- a/tests/qemu-iotests/051
+++ b/tests/qemu-iotests/051
@@ -29,6 +29,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+	_cleanup_qemu
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
@@ -36,6 +37,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
+. ./common.qemu
 
 _supported_fmt qcow2
 _supported_proto file
@@ -45,7 +47,6 @@ _supported_proto file
 _unsupported_imgopts 'refcount_bits=\([^1]\|.\([^6]\|$\)\)' data_file \
     compression_type
 _require_drivers nbd
-_require_hmp
 
 if [ "$QEMU_DEFAULT_MACHINE" = "pc" ]; then
     _require_devices lsi53c895a
@@ -55,20 +56,22 @@ do_run_qemu()
 {
     echo Testing: "$@"
     (
+        echo '{"execute":"qmp_capabilities"}'
         if ! test -t 0; then
             while read cmd; do
-                echo $cmd
+                echo "$cmd"
             done
         fi
-        echo quit
-    ) | $QEMU -nographic -monitor stdio -serial none "$@"
+        echo '{"execute":"quit"}'
+    ) | $QEMU -nographic -qmp stdio -serial none "$@"
     echo
 }
 
 run_qemu()
 {
-    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu |
-        _filter_generated_node_ids | _filter_hmp
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu \
+        | _filter_generated_node_ids | _filter_qmp | _filter_qmp_empty_return \
+        | _filter_actual_image_size
 }
 
 size=128M
@@ -131,8 +134,8 @@ echo
 echo === Overriding backing file ===
 echo
 
-echo "info block" | run_qemu -drive file="$TEST_IMG",driver=qcow2,backing.file.filename="$TEST_IMG.orig",if=none,id=$device_id -nodefaults\
-                  | _filter_generated_node_ids
+echo "{ 'execute': 'query-block' }" | \
+    run_qemu -drive file="$TEST_IMG",driver=qcow2,backing.file.filename="$TEST_IMG.orig",if=none,id=$device_id -nodefaults
 
 # Drivers that don't support backing files
 run_qemu -drive file="$TEST_IMG",driver=raw,backing.file.filename="$TEST_IMG.orig"
@@ -257,7 +260,7 @@ run_qemu -drive driver=null-co,cache=invalid_value
 # Test 142 checks the direct=on cases
 
 for cache in writeback writethrough unsafe invalid_value; do
-    printf "info block %s\n" '' file backing backing-file | \
+    printf '%s\n' "{ 'execute': 'query-block' }" "{ 'execute': 'query-named-block-nodes' }" | \
     run_qemu -drive file="$TEST_IMG",cache=$cache,backing.file.filename="$TEST_IMG.base",backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=$device_id -nodefaults
 done
 
@@ -343,31 +346,56 @@ echo
 
 $QEMU_IO -c "write -P 0x11 0 4k" "$TEST_IMG" | _filter_qemu_io
 
+qmp_write_22="{ 'execute': 'x-qemu-io', 'arguments': { 'device': '$device_id', 'command': 'write -P 0x22 0 4k' } }"
 
-echo "qemu-io $device_id \"write -P 0x22 0 4k\"" | run_qemu -drive file="$TEST_IMG",if=none,id=$device_id -snapshot | _filter_qemu_io
-echo "qemu-io $device_id \"write -P 0x22 0 4k\"" | run_qemu -drive file="$TEST_IMG",snapshot=on,if=none,id=$device_id | _filter_qemu_io
-echo "qemu-io $device_id \"write -P 0x22 0 4k\"" | run_qemu -drive file.filename="$TEST_IMG",driver=qcow2,snapshot=on,if=none,id=$device_id\
+echo "$qmp_write_22" | run_qemu -drive file="$TEST_IMG",if=none,id=$device_id -snapshot | _filter_qemu_io
+echo "$qmp_write_22" | run_qemu -drive file="$TEST_IMG",snapshot=on,if=none,id=$device_id | _filter_qemu_io
+echo "$qmp_write_22" | run_qemu -drive file.filename="$TEST_IMG",driver=qcow2,snapshot=on,if=none,id=$device_id\
                                                  | _filter_qemu_io
-echo "qemu-io $device_id \"write -P 0x22 0 4k\"" | run_qemu -drive file.filename="$TEST_IMG",driver=qcow2,if=none,id=$device_id -snapshot\
+echo "$qmp_write_22" | run_qemu -drive file.filename="$TEST_IMG",driver=qcow2,if=none,id=$device_id -snapshot\
                                                  | _filter_qemu_io
-echo "qemu-io $device_id \"write -P 0x22 0 4k\"" | run_qemu -drive file="file:$TEST_IMG",if=none,id=$device_id -snapshot | _filter_qemu_io
-echo "qemu-io $device_id \"write -P 0x22 0 4k\"" | run_qemu -drive file="file:$TEST_IMG",snapshot=on,if=none,id=$device_id | _filter_qemu_io
+echo "$qmp_write_22" | run_qemu -drive file="file:$TEST_IMG",if=none,id=$device_id -snapshot | _filter_qemu_io
+echo "$qmp_write_22" | run_qemu -drive file="file:$TEST_IMG",snapshot=on,if=none,id=$device_id | _filter_qemu_io
 
 # Opening a read-only file r/w with snapshot=on
 chmod u-w "$TEST_IMG"
-echo "qemu-io $device_id \"write -P 0x22 0 4k\"" | run_qemu -drive file="$TEST_IMG",if=none,id=$device_id -snapshot | _filter_qemu_io
-echo "qemu-io $device_id \"write -P 0x22 0 4k\"" | run_qemu -drive file="$TEST_IMG",snapshot=on,if=none,id=$device_id | _filter_qemu_io
+echo "$qmp_write_22" | run_qemu -drive file="$TEST_IMG",if=none,id=$device_id -snapshot | _filter_qemu_io
+echo "$qmp_write_22" | run_qemu -drive file="$TEST_IMG",snapshot=on,if=none,id=$device_id | _filter_qemu_io
 chmod u+w "$TEST_IMG"
 
 $QEMU_IO -c "read -P 0x11 0 4k" "$TEST_IMG" | _filter_qemu_io
 
-echo "qemu-io $device_id \"write -P 0x22 0 4k\"" | run_qemu -drive file="$TEST_IMG",snapshot=off,if=none,id=$device_id | _filter_qemu_io
+echo "$qmp_write_22" | run_qemu -drive file="$TEST_IMG",snapshot=off,if=none,id=$device_id | _filter_qemu_io
 
 $QEMU_IO -c "read -P 0x22 0 4k" "$TEST_IMG" | _filter_qemu_io
 
-printf %b "qemu-io $device_id \"write -P 0x33 0 4k\"\ncommit $device_id\n" |
-    run_qemu -drive file="$TEST_IMG",snapshot=on,if=none,id=$device_id |
-    _filter_qemu_io
+echo "Testing: -drive file=$TEST_IMG,snapshot=on,if=none,id=$device_id" |
+    _filter_testdir
+_launch_qemu -drive file="$TEST_IMG",snapshot=on,if=none,id=$device_id
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'x-qemu-io', 'arguments': { 'device': '$device_id', 'command': 'write -P 0x33 0 4k' } }" \
+    'return'
+qmp_commit="{ 'execute': 'block-commit', 'arguments': { 'device': '$device_id', 'job-id': 'job0' } }"
+echo "$qmp_commit"
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "$qmp_commit" \
+    'return'
+silent=yes _timed_wait_for $QEMU_HANDLE '"ready"'
+qmp_complete="{ 'execute': 'block-job-complete', 'arguments': { 'device': 'job0' } }"
+echo "$qmp_complete"
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "$qmp_complete" \
+    'return'
+silent=yes _timed_wait_for $QEMU_HANDLE '"null"'
+echo "block job completed"
+silent=yes _send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'quit' }" \
+    'return'
+wait=1 _cleanup_qemu
+echo
 
 $QEMU_IO -c "read -P 0x33 0 4k" "$TEST_IMG" | _filter_qemu_io
 
@@ -380,10 +408,9 @@ TMPDIR=/nonexistent run_qemu -drive driver=null-co,snapshot=on |
     sed -e "s#'[^']*/vl\.[A-Za-z0-9]\{6\}'#SNAPSHOT_PATH#g"
 
 # Using snapshot=on together with read-only=on
-echo "info block" |
+echo "{ 'execute': 'query-block' }" |
     run_qemu -drive file="$TEST_IMG",snapshot=on,read-only=on,if=none,id=$device_id |
-    _filter_qemu_io |
-    sed -e 's#"[^"]*/vl\.[A-Za-z0-9]\{6\}"#SNAPSHOT_PATH#g'
+    sed -e 's|/[^"[:space:]]*/vl\.[A-Za-z0-9]\{6\}|SNAPSHOT_PATH|g'
 
 
 # success, all done
diff --git a/tests/qemu-iotests/051.out b/tests/qemu-iotests/051.out
index d46215640506..30972e390e75 100644
--- a/tests/qemu-iotests/051.out
+++ b/tests/qemu-iotests/051.out
@@ -50,15 +50,15 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2: Cannot specif
 === Node names ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,node-name=x123456789012345678901234567890
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,node-name=x1234567890123456789012345678901
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=x1234567890123456789012345678901: Node name too long
 
 Testing: -drive file=TEST_DIR/t.qcow2,node-name=All-Types.of_all0wed_chars
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,node-name=123foo
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=123foo: Invalid node-name: '123foo'
@@ -73,20 +73,16 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=foo#12: Invalid node-name: 'fo
 === Device without drive ===
 
 Testing: -device virtio-scsi -device scsi-hd
-QEMU X.Y.Z monitor - type 'help' for more information
+QMP_VERSION
 QEMU_PROG: -device scsi-hd: drive property not set
 
 
 === Overriding backing file ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,backing.file.filename=TEST_DIR/t.qcow2.orig,if=none,id=drive0 -nodefaults
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-    Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "drive0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.orig", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "backing-filename-format": "qcow2", "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DI
 R/t.qcow2.orig\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "full-backing-filename": "TEST_DIR/t.qcow2.base", "backing-filename": "TEST_DIR/t.qcow2.base", "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "backing"}, {"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backing_file": "TEST_DIR/t.qcow2.orig", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.orig\"}}
 , \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,driver=raw,backing.file.filename=TEST_DIR/t.qcow2.orig
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=raw,backing.file.filename=TEST_DIR/t.qcow2.orig: Driver doesn't support backing files
@@ -102,12 +98,12 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,file.backing.driver=qcow2,file.backing.f
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=off
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=: Parameter 'lazy-refcounts' expects 'on' or 'off'
@@ -126,14 +122,14 @@ Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on: Lazy refcounts require a qcow2 image with at least qemu 1.1 compatibility level
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=off
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === No medium ===
 
 Testing: -drive if=virtio
-QEMU X.Y.Z monitor - type 'help' for more information
+QMP_VERSION
 QEMU_PROG: -drive if=virtio: Device needs media, but drive is empty
 
 
@@ -143,94 +139,52 @@ QEMU_PROG: -drive if=virtio: Device needs media, but drive is empty
 === Read-only ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Cache modes ===
 
 Testing: -drive driver=null-co,read-zeroes=on,cache=none
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive driver=null-co,read-zeroes=on,cache=directsync
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive driver=null-co,read-zeroes=on,cache=writeback
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive driver=null-co,read-zeroes=on,cache=writethrough
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive driver=null-co,read-zeroes=on,cache=unsafe
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive driver=null-co,cache=invalid_value
 QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-    Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) info block file
-
-file: TEST_DIR/t.qcow2 (file)
-    Cache mode:       writeback
-(qemu) info block backing
-backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) info block backing-file
-
-backing-file: TEST_DIR/t.qcow2.base (file, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "drive0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qc
 ow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backing_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, "type": "unknown"}]}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [{"node-name": "backing-file", "child": "file"}], "node-name": "backing", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-a
 lignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2.base", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "backing-file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compr
 ession-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backi
 ng_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
-    Removable device: not locked, tray closed
-    Cache mode:       writethrough
-    Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) info block file
-
-file: TEST_DIR/t.qcow2 (file)
-    Cache mode:       writeback
-(qemu) info block backing
-backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) info block backing-file
-
-backing-file: TEST_DIR/t.qcow2.base (file, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "drive0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qc
 ow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backing_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": false}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, "type": "unknown"}]}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [{"node-name": "backing-file", "child": "file"}], "node-name": "backing", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-a
 lignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2.base", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "backing-file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compr
 ession-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backi
 ng_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback, ignore flushes
-    Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) info block file
-
-file: TEST_DIR/t.qcow2 (file)
-    Cache mode:       writeback, ignore flushes
-(qemu) info block backing
-backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) info block backing-file
-
-backing-file: TEST_DIR/t.qcow2.base (file, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "drive0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qc
 ow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backing_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, "type": "unknown"}]}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [{"node-name": "backing-file", "child": "file"}], "node-name": "backing", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-a
 lignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2.base", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "backing-file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compr
 ession-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backi
 ng_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0: invalid cache option
@@ -239,8 +193,8 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filenam
 === Specifying the protocol layer ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,file.driver=file
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Leaving out required options ===
@@ -336,16 +290,16 @@ Testing: -drive file=TEST_DIR/t.qcow2,throttling.bps-total=-5
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,throttling.bps-total=-5: bps/iops/max values must be within [0, 1000000000000000]
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1000000000000000
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1000000000000001
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps=1000000000000001: bps/iops/max values must be within [0, 1000000000000000]
@@ -366,12 +320,12 @@ Testing: -drive file.filename=foo:bar
 QEMU_PROG: -drive file.filename=foo:bar: Could not open 'foo:bar': No such file or directory
 
 Testing: -hda file:TEST_DIR/t.qcow2
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=file:TEST_DIR/t.qcow2
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file.filename=file:TEST_DIR/t.qcow2
 QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST_DIR/t.qcow2': No such file or directory
@@ -382,79 +336,60 @@ QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file.filename=TEST_DIR/t.qcow2,driver=qcow2,snapshot=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file.filename=TEST_DIR/t.qcow2,driver=qcow2,if=none,id=drive0 -snapshot
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=file:TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=file:TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=off,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x33 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) commit drive0
-(qemu) quit
+{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'drive0', 'command': 'write -P 0x33 0 4k' } }
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'block-commit', 'arguments': { 'device': 'drive0', 'job-id': 'job0' } }
+{ 'execute': 'block-job-complete', 'arguments': { 'device': 'job0' } }
+block job completed
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -462,12 +397,8 @@ Testing: -drive driver=null-co,snapshot=on
 QEMU_PROG: -drive driver=null-co,snapshot=on: Could not open temporary file SNAPSHOT_PATH: No such file or directory
 
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,read-only=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}}, "driver": "qcow2", "file": {"driver": "file", "filename": SNAPSHOT_PATH}} (qcow2, read-only)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback, ignore flushes
-    Backing file:     TEST_DIR/t.qcow2 (chain depth: 1)
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "drive0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"SNAPSHOT_PATH\"}}"
 , "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [{"node-name": "NODE_NAME", "child": "backing"}, {"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backing_file": "TEST_DIR/t.qcow2", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"SNAPSHOT_PATH\"}}"}, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 *** done
diff --git a/tests/qemu-iotests/051.pc.out b/tests/qemu-iotests/051.pc.out
index f19b532eb9b6..7348aad4d464 100644
--- a/tests/qemu-iotests/051.pc.out
+++ b/tests/qemu-iotests/051.pc.out
@@ -50,15 +50,15 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=qcow2,format=qcow2: Cannot specif
 === Node names ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,node-name=x123456789012345678901234567890
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,node-name=x1234567890123456789012345678901
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=x1234567890123456789012345678901: Node name too long
 
 Testing: -drive file=TEST_DIR/t.qcow2,node-name=All-Types.of_all0wed_chars
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,node-name=123foo
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=123foo: Invalid node-name: '123foo'
@@ -73,20 +73,16 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,node-name=foo#12: Invalid node-name: 'fo
 === Device without drive ===
 
 Testing: -device virtio-scsi -device scsi-hd
-QEMU X.Y.Z monitor - type 'help' for more information
+QMP_VERSION
 QEMU_PROG: -device scsi-hd: drive property not set
 
 
 === Overriding backing file ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,driver=qcow2,backing.file.filename=TEST_DIR/t.qcow2.orig,if=none,id=drive0 -nodefaults
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.orig"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-    Backing file:     TEST_DIR/t.qcow2.orig (chain depth: 1)
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "drive0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.orig", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "backing-filename-format": "qcow2", "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DI
 R/t.qcow2.orig\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "full-backing-filename": "TEST_DIR/t.qcow2.base", "backing-filename": "TEST_DIR/t.qcow2.base", "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "NODE_NAME", "child": "backing"}, {"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backing_file": "TEST_DIR/t.qcow2.orig", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.orig\"}}
 , \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,driver=raw,backing.file.filename=TEST_DIR/t.qcow2.orig
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,driver=raw,backing.file.filename=TEST_DIR/t.qcow2.orig: Driver doesn't support backing files
@@ -102,12 +98,12 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,file.backing.driver=qcow2,file.backing.f
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=off
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=: Parameter 'lazy-refcounts' expects 'on' or 'off'
@@ -126,191 +122,149 @@ Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=on: Lazy refcounts require a qcow2 image with at least qemu 1.1 compatibility level
 
 Testing: -drive file=TEST_DIR/t.qcow2,format=qcow2,lazy-refcounts=off
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === No medium ===
 
 Testing: -drive if=floppy
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive if=ide,media=cdrom
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive if=ide
-QEMU X.Y.Z monitor - type 'help' for more information
+QMP_VERSION
 QEMU_PROG: Device needs media, but drive is empty
 
 Testing: -drive if=virtio
-QEMU X.Y.Z monitor - type 'help' for more information
+QMP_VERSION
 QEMU_PROG: -drive if=virtio: Device needs media, but drive is empty
 
 Testing: -drive if=none,id=disk -device ide-cd,drive=disk
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive if=none,id=disk -device lsi53c895a -device scsi-cd,drive=disk
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive if=none,id=disk -device ide-hd,drive=disk
-QEMU X.Y.Z monitor - type 'help' for more information
+QMP_VERSION
 QEMU_PROG: -device ide-hd,drive=disk: Device needs media, but drive is empty
 
 Testing: -drive if=none,id=disk -device lsi53c895a -device scsi-hd,drive=disk
-QEMU X.Y.Z monitor - type 'help' for more information
+QMP_VERSION
 QEMU_PROG: -device scsi-hd,drive=disk: Device needs media, but drive is empty
 
 
 === Attach to node in non-default iothread ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device ide-hd,drive=disk,share-rw=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device ide-hd,drive=disk,share-rw=on: Cannot change iothread of active block backend
+QMP_VERSION
+QEMU_PROG: -device ide-hd,drive=disk,share-rw=on: Cannot change iothread of active block backend
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-blk-pci,drive=disk,share-rw=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device virtio-blk-pci,drive=disk,share-rw=on: Cannot change iothread of active block backend
+QMP_VERSION
+QEMU_PROG: -device virtio-blk-pci,drive=disk,share-rw=on: Cannot change iothread of active block backend
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device lsi53c895a,id=lsi0 -device scsi-hd,bus=lsi0.0,drive=disk,share-rw=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device scsi-hd,bus=lsi0.0,drive=disk,share-rw=on: HBA does not support iothreads
+QMP_VERSION
+QEMU_PROG: -device scsi-hd,bus=lsi0.0,drive=disk,share-rw=on: HBA does not support iothreads
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-scsi,id=virtio-scsi1 -device scsi-hd,bus=virtio-scsi1.0,drive=disk,share-rw=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-blk-pci,drive=disk,iothread=thread0,share-rw=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: -device virtio-blk-pci,drive=disk,iothread=thread0,share-rw=on: Cannot change iothread of active block backend
+QMP_VERSION
+QEMU_PROG: -device virtio-blk-pci,drive=disk,iothread=thread0,share-rw=on: Cannot change iothread of active block backend
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,node-name=disk -object iothread,id=thread0 -device virtio-scsi,iothread=thread0,id=virtio-scsi0 -device scsi-hd,bus=virtio-scsi0.0,drive=disk,share-rw=on -device virtio-scsi,id=virtio-scsi1,iothread=thread0 -device scsi-hd,bus=virtio-scsi1.0,drive=disk,share-rw=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Read-only ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=floppy,readonly=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,media=cdrom,readonly=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=ide,readonly=on
-QEMU X.Y.Z monitor - type 'help' for more information
+QMP_VERSION
 QEMU_PROG: Block node is read-only
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=virtio,readonly=on
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-cd,drive=disk
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device lsi53c895a -device scsi-cd,drive=disk
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device ide-hd,drive=disk
-QEMU X.Y.Z monitor - type 'help' for more information
+QMP_VERSION
 QEMU_PROG: -device ide-hd,drive=disk: Block node is read-only
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=disk,readonly=on -device lsi53c895a -device scsi-hd,drive=disk
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Cache modes ===
 
 Testing: -drive driver=null-co,read-zeroes=on,cache=none
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive driver=null-co,read-zeroes=on,cache=directsync
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive driver=null-co,read-zeroes=on,cache=writeback
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive driver=null-co,read-zeroes=on,cache=writethrough
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive driver=null-co,read-zeroes=on,cache=unsafe
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive driver=null-co,cache=invalid_value
 QEMU_PROG: -drive driver=null-co,cache=invalid_value: invalid cache option
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writeback,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback
-    Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) info block file
-
-file: TEST_DIR/t.qcow2 (file)
-    Cache mode:       writeback
-(qemu) info block backing
-backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) info block backing-file
-
-backing-file: TEST_DIR/t.qcow2.base (file, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "drive0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qc
 ow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backing_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, "type": "unknown"}]}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [{"node-name": "backing-file", "child": "file"}], "node-name": "backing", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-a
 lignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2.base", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "backing-file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compr
 ession-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backi
 ng_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=writethrough,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
-    Removable device: not locked, tray closed
-    Cache mode:       writethrough
-    Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) info block file
-
-file: TEST_DIR/t.qcow2 (file)
-    Cache mode:       writeback
-(qemu) info block backing
-backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) info block backing-file
-
-backing-file: TEST_DIR/t.qcow2.base (file, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "drive0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qc
 ow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backing_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": false}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, "type": "unknown"}]}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [{"node-name": "backing-file", "child": "file"}], "node-name": "backing", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-a
 lignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2.base", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "backing-file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compr
 ession-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backi
 ng_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": false, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=unsafe,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2.base"}}, "driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}} (qcow2)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback, ignore flushes
-    Backing file:     TEST_DIR/t.qcow2.base (chain depth: 1)
-(qemu) info block file
-
-file: TEST_DIR/t.qcow2 (file)
-    Cache mode:       writeback, ignore flushes
-(qemu) info block backing
-backing: TEST_DIR/t.qcow2.base (qcow2, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) info block backing-file
-
-backing-file: TEST_DIR/t.qcow2.base (file, read-only)
-    Cache mode:       writeback, ignore flushes
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "drive0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qc
 ow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backing_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, "type": "unknown"}]}
+{"return": [{"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [{"node-name": "backing-file", "child": "file"}], "node-name": "backing", "backing_file_depth": 0, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-a
 lignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2.base", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [], "node-name": "backing-file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2.base"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2.base", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compr
 ession-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [{"node-name": "backing", "child": "backing"}, {"node-name": "file", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backi
 ng_file": "TEST_DIR/t.qcow2.base", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2.base\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}"}, {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"limits": {"request-alignment": 1, "min-mem-alignment": 1, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 197120, "filename": "TEST_DIR/t.qcow2", "format": "file", "actual-size": SIZE, "format-specific": {"type": "file", "data": {}}, "dirty-flag": false}, "iops_wr": 0, "ro": false, "children": [], "node-name": "file", "backing_file_depth": 0, "drv": "file", "iops": 0, "bps_wr": 0, "write_threshold": 0, "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "TEST_DIR/t.qcow2"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0 -nodefaults
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filename=TEST_DIR/t.qcow2.base,backing.cache.no-flush=on,backing.node-name=backing,backing.file.node-name=backing-file,file.node-name=file,if=none,id=drive0: invalid cache option
@@ -319,8 +273,8 @@ QEMU_PROG: -drive file=TEST_DIR/t.qcow2,cache=invalid_value,backing.file.filenam
 === Specifying the protocol layer ===
 
 Testing: -drive file=TEST_DIR/t.qcow2,file.driver=file
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 
 === Leaving out required options ===
@@ -416,16 +370,16 @@ Testing: -drive file=TEST_DIR/t.qcow2,throttling.bps-total=-5
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,throttling.bps-total=-5: bps/iops/max values must be within [0, 1000000000000000]
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1000000000000000
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,bps=1000000000000001
 QEMU_PROG: -drive file=TEST_DIR/t.qcow2,bps=1000000000000001: bps/iops/max values must be within [0, 1000000000000000]
@@ -446,12 +400,12 @@ Testing: -drive file.filename=foo:bar
 QEMU_PROG: -drive file.filename=foo:bar: Could not open 'foo:bar': No such file or directory
 
 Testing: -hda file:TEST_DIR/t.qcow2
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=file:TEST_DIR/t.qcow2
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) quit
+QMP_VERSION
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file.filename=file:TEST_DIR/t.qcow2
 QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST_DIR/t.qcow2': No such file or directory
@@ -462,79 +416,60 @@ QEMU_PROG: -drive file.filename=file:TEST_DIR/t.qcow2: Could not open 'file:TEST
 wrote 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file.filename=TEST_DIR/t.qcow2,driver=qcow2,snapshot=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file.filename=TEST_DIR/t.qcow2,driver=qcow2,if=none,id=drive0 -snapshot
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=file:TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=file:TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,if=none,id=drive0 -snapshot
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=off,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x22 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io drive0 "write -P 0x33 0 4k"
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) commit drive0
-(qemu) quit
+{ 'execute': 'x-qemu-io', 'arguments': { 'device': 'drive0', 'command': 'write -P 0x33 0 4k' } }
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'block-commit', 'arguments': { 'device': 'drive0', 'job-id': 'job0' } }
+{ 'execute': 'block-job-complete', 'arguments': { 'device': 'job0' } }
+block job completed
 
 read 4096/4096 bytes at offset 0
 4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
@@ -542,12 +477,8 @@ Testing: -drive driver=null-co,snapshot=on
 QEMU_PROG: -drive driver=null-co,snapshot=on: Could not open temporary file SNAPSHOT_PATH: No such file or directory
 
 Testing: -drive file=TEST_DIR/t.qcow2,snapshot=on,read-only=on,if=none,id=drive0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) info block
-drive0 (NODE_NAME): json:{"backing": {"driver": "qcow2", "file": {"driver": "file", "filename": "TEST_DIR/t.qcow2"}}, "driver": "qcow2", "file": {"driver": "file", "filename": SNAPSHOT_PATH}} (qcow2, read-only)
-    Removable device: not locked, tray closed
-    Cache mode:       writeback, ignore flushes
-    Backing file:     TEST_DIR/t.qcow2 (chain depth: 1)
-(qemu) quit
+QMP_VERSION
+{"return": [{"device": "drive0", "locked": false, "removable": true, "inserted": {"iops_rd": 0, "detect_zeroes": "off", "active": true, "image": {"backing-image": {"limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "TEST_DIR/t.qcow2", "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "0.10", "compression-type": "zlib", "refcount-bits": 16}}, "dirty-flag": false}, "limits": {"write-zeroes-alignment": 65536, "request-alignment": 1, "min-mem-alignment": 1, "discard-alignment": 65536, "opt-mem-alignment": 4096, "max-iov": 1024}, "virtual-size": 134217728, "filename": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"SNAPSHOT_PATH\"}}"
 , "cluster-size": 65536, "format": "qcow2", "actual-size": SIZE, "format-specific": {"type": "qcow2", "data": {"compat": "1.1", "compression-type": "zlib", "lazy-refcounts": false, "refcount-bits": 16, "corrupt": false, "extended-l2": false}}, "dirty-flag": false}, "iops_wr": 0, "ro": true, "children": [{"node-name": "NODE_NAME", "child": "backing"}, {"node-name": "NODE_NAME", "child": "file"}], "node-name": "NODE_NAME", "backing_file_depth": 1, "drv": "qcow2", "iops": 0, "bps_wr": 0, "write_threshold": 0, "backing_file": "TEST_DIR/t.qcow2", "encrypted": false, "bps": 0, "bps_rd": 0, "cache": {"no-flush": true, "direct": false, "writeback": true}, "file": "json:{\"backing\": {\"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"TEST_DIR/t.qcow2\"}}, \"driver\": \"qcow2\", \"file\": {\"driver\": \"file\", \"filename\": \"SNAPSHOT_PATH\"}}"}, "type": "unknown"}]}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


