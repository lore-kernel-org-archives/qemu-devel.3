Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DA10C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:29:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x974d-0004zD-N5; Tue, 22 Sep 2026 16:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972F-00018i-CX
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972A-0000a1-Ch
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vcsFqAShCWyBQOCRfo3cy+/x60my1BS7qUt9F/KDa+c=;
 b=i3p9ddvEEktfksnt+xj8yF8d8FpGX8DIykqvzgry21mZYJiTnn32QMfEG8J0kCEVlXT63y
 fhz8ONZrlSz/eI5GnJ9MkPT7HYmTp2+uwWxZohQCDvrYHdexwsCFOZTEcc4TBOP0J3PIgn
 095KU5wuRytXNWfyYfGoFJYk8sQq5n8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-fwKfVv1bNRGwaFtXacmONA-1; Tue,
 22 Sep 2026 16:24:08 -0400
X-MC-Unique: fwKfVv1bNRGwaFtXacmONA-1
X-Mimecast-MFC-AGG-ID: fwKfVv1bNRGwaFtXacmONA_1790108647
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C4941955E86; Tue, 22 Sep 2026 20:24:07 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DFA043000223; Tue, 22 Sep 2026 20:24:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:30 +0400
Subject: [PATCH 83/88] qemu-iotests/267: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-83-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=41267;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ML7PxDngHFqharBEJ3m9Lfq//oAnaCOUk1Soj4x9UdM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuK0q32W2jIVZAtGs5/bejiQJWgxVSJnVxj+n
 8Cz/2arxSCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLitAAKCRDa6OEJdZac
 5f32D/9BuqwoTNFrUozh+jCW1ztWwwBi5OiQrQQ36eTvZ+tw42yPlfDtwTgC1Gj61fDlmdQ6meZ
 SBMXReJgosmUXjEAzFxchIE/VK4LHIih/hWS/oVOC/l9Iesyq/uMHiiTdcW9EDj+mbXaZN72sa4
 0WLEm57Sp8b6n6e4UUX/gK5vZyAyIpQrBJ+jLqx0UwXt4MaJVYv+/x5VERR1zgoT9SiBqBKrico
 BStDQAdzFZetLVCrE7IcHyznchj0owWZ0nuPwoZcFB6MLfU9E1eYAnVOph8rQMFP5jAxKU2ejFg
 Fq/LArPn8BqFW/gKocbjhdpu2K+y//BWG1+l+xusWdwFepn7ZgAm/td81k+mOjWoN17BfUEzWsI
 dvolQ0RvnIOIhyDEoVLReXl5RccR1N4bBqcBs4X6+5f07VC62T/qMp/U5BTpHgeaNdpd2quP3lc
 Bl6DjCr2Dm6nRNsz4Uc04Voih07CwePXEmbHry7thIF0Ji6AbJS6teFAWwx0U3DVbHXbZ4thWRe
 W93Hd05vSvwFoo90YjxZqNBr2lURMccYpf/Xfk3AO/3px7O7dkj5qOf0DTZ6IQCBdGGAc5r4LTm
 oPUuHVJGxJySm7Q05C1jcAQmXT7WIyMA+IyxizmpNGsUFZmZCzgJxQXFtIABJ5pdF9ZzJYVcOhE
 oWBB8/jxGByqg1A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace pipe-based HMP savevm/loadvm, nbd_server_start/add, and
info snapshots with QMP equivalents.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/267     | 139 +++++++++-----
 tests/qemu-iotests/267.out | 447 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 435 insertions(+), 151 deletions(-)

diff --git a/tests/qemu-iotests/267 b/tests/qemu-iotests/267
index e14aeb1f18d0..68c2f2cbebb1 100755
--- a/tests/qemu-iotests/267
+++ b/tests/qemu-iotests/267
@@ -29,6 +29,7 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+    _cleanup_qemu
     _cleanup_test_img
     rm -f "$SOCK_DIR/nbd"
 }
@@ -37,6 +38,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
+. ./common.qemu
 
 _supported_fmt qcow2
 _supported_proto file
@@ -48,38 +50,53 @@ _require_drivers copy-on-read
 _unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
 
 _require_devices virtio-blk
-_require_hmp
-
-do_run_qemu()
-{
-    echo Testing: "$@"
-    (
-        if ! test -t 0; then
-            while read cmd; do
-                echo $cmd
-            done
-        fi
-        echo quit
-    ) | $QEMU -nographic -monitor stdio -nodefaults "$@"
-    echo
-}
-
-run_qemu()
-{
-    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp |
-        _filter_generated_node_ids | _filter_imgfmt | _filter_vmstate_size
-}
 
 size=128M
 
+# snapshot-save/snapshot-load are job-based QMP commands; wait for
+# "concluded" (auto-dismiss to "null" only fires on the next command).
 run_test()
 {
+    local snapshot_node="$1"
+    shift
+
     if [ -n "$BACKING_FILE" ]; then
         _make_test_img -b "$BACKING_FILE" -F $IMGFMT $size
     else
         _make_test_img $size
     fi
-    printf "savevm snap0\ninfo snapshots\nloadvm snap0\n" | run_qemu "$@" | _filter_date
+
+    echo Testing: "$@" | _filter_testdir | _filter_imgfmt
+    _launch_qemu -nodefaults "$@"
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'qmp_capabilities' }" \
+        'return'
+
+    # snapshot-save
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': '$snapshot_node',
+                          'devices': [\"$snapshot_node\"] } }" \
+        'return'
+    silent=yes _send_qemu_cmd $QEMU_HANDLE '' '"concluded"'
+
+    # snapshot-load
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': '$snapshot_node',
+                          'devices': [\"$snapshot_node\"] } }" \
+        'return'
+    silent=yes _send_qemu_cmd $QEMU_HANDLE '' '"concluded"'
+
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'quit' }" \
+        'return'
+    wait=1 _cleanup_qemu
+
+    $QEMU_IMG snapshot -l "$TEST_IMG" | _filter_date | _filter_vmstate_size
+    echo
 }
 
 
@@ -87,31 +104,31 @@ echo
 echo "=== No block devices at all ==="
 echo
 
-run_test
+run_test nonexistent
 
 echo
 echo "=== -drive if=none ==="
 echo
 
-run_test -drive driver=file,file="$TEST_IMG",if=none
-run_test -drive driver=$IMGFMT,file="$TEST_IMG",if=none
-run_test -drive driver=$IMGFMT,file="$TEST_IMG",if=none -device virtio-blk,drive=none0
+run_test drv0 -drive driver=file,file="$TEST_IMG",if=none,node-name=drv0
+run_test drv0 -drive driver=$IMGFMT,file="$TEST_IMG",if=none,node-name=drv0
+run_test drv0 -drive driver=$IMGFMT,file="$TEST_IMG",if=none,node-name=drv0 -device virtio-blk,drive=none0
 
 echo
 echo "=== -drive if=virtio ==="
 echo
 
-run_test -drive driver=file,file="$TEST_IMG",if=virtio
-run_test -drive driver=$IMGFMT,file="$TEST_IMG",if=virtio
+run_test drv0 -drive driver=file,file="$TEST_IMG",if=virtio,node-name=drv0
+run_test drv0 -drive driver=$IMGFMT,file="$TEST_IMG",if=virtio,node-name=drv0
 
 echo
 echo "=== Simple -blockdev ==="
 echo
 
-run_test -blockdev driver=file,filename="$TEST_IMG",node-name=file
-run_test -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+run_test file -blockdev driver=file,filename="$TEST_IMG",node-name=file
+run_test fmt -blockdev driver=file,filename="$TEST_IMG",node-name=file \
          -blockdev driver=$IMGFMT,file=file,node-name=fmt
-run_test -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+run_test fmt -blockdev driver=file,filename="$TEST_IMG",node-name=file \
          -blockdev driver=raw,file=file,node-name=raw \
          -blockdev driver=$IMGFMT,file=raw,node-name=fmt
 
@@ -119,7 +136,7 @@ echo
 echo "=== -blockdev with a filter on top ==="
 echo
 
-run_test -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+run_test fmt -blockdev driver=file,filename="$TEST_IMG",node-name=file \
          -blockdev driver=$IMGFMT,file=file,node-name=fmt \
          -blockdev driver=copy-on-read,file=fmt,node-name=filter
 
@@ -130,12 +147,12 @@ echo
 TEST_IMG="$TEST_IMG.base" _make_test_img $size
 
 BACKING_FILE="$TEST_IMG.base" \
-run_test -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
+run_test fmt -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
          -blockdev driver=file,filename="$TEST_IMG",node-name=file \
          -blockdev driver=$IMGFMT,file=file,backing=backing-file,node-name=fmt
 
 BACKING_FILE="$TEST_IMG.base" \
-run_test -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
+run_test fmt -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
          -blockdev driver=$IMGFMT,file=backing-file,node-name=backing-fmt \
          -blockdev driver=file,filename="$TEST_IMG",node-name=file \
          -blockdev driver=$IMGFMT,file=file,backing=backing-fmt,node-name=fmt
@@ -152,18 +169,48 @@ echo "=== -blockdev with NBD server on the backing file ==="
 echo
 
 _make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
-cat <<EOF |
-nbd_server_start unix:$SOCK_DIR/nbd
-nbd_server_add -w backing-fmt
-savevm snap0
-info snapshots
-loadvm snap0
-EOF
-run_qemu -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
-         -blockdev driver=$IMGFMT,file=backing-file,node-name=backing-fmt \
-         -blockdev driver=file,filename="$TEST_IMG",node-name=file \
-         -blockdev driver=$IMGFMT,file=file,backing=backing-fmt,node-name=fmt |
-         _filter_date
+
+_launch_qemu -nodefaults \
+    -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
+    -blockdev driver=$IMGFMT,file=backing-file,node-name=backing-fmt \
+    -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+    -blockdev driver=$IMGFMT,file=file,backing=backing-fmt,node-name=fmt
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'nbd-server-start',
+       'arguments': { 'addr': { 'type': 'unix',
+                                'data': { 'path': '$SOCK_DIR/nbd' } } } }" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'nbd-server-add',
+       'arguments': { 'device': 'backing-fmt', 'writable': true } }" \
+    'return'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'snapshot-save',
+       'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                      'vmstate': 'fmt',
+                      'devices': [\"fmt\", \"backing-fmt\"] } }" \
+    'return'
+silent=yes _send_qemu_cmd $QEMU_HANDLE '' '"concluded"'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'snapshot-load',
+       'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                      'vmstate': 'fmt',
+                      'devices': [\"fmt\", \"backing-fmt\"] } }" \
+    'return'
+silent=yes _send_qemu_cmd $QEMU_HANDLE '' '"concluded"'
+
+_send_qemu_cmd $QEMU_HANDLE \
+    "{ 'execute': 'quit' }" \
+    'return'
+wait=1 _cleanup_qemu
 
 # This time, a snapshot should be created on both files
 echo Internal snapshots on overlay:
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 37b7ebd28049..30e094f8b98f 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -4,125 +4,301 @@ QA output created by 267
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing:
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-Error: no block device can store vmstate for snapshot
-(qemu) info snapshots
-Error: no block device can store vmstate for snapshot
-(qemu) loadvm snap0
-Error: no block device can store vmstate for snapshot
-(qemu) quit
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'nonexistent',
+                          'devices': ["nonexistent"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'nonexistent',
+                          'devices': ["nonexistent"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
 
 
 === -drive if=none ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Testing: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-Error: Device 'none0' is writable but does not support snapshots
-(qemu) info snapshots
-Error: no block device can store vmstate for snapshot
-(qemu) loadvm snap0
-Error: Device 'none0' is writable but does not support snapshots
-(qemu) quit
+Testing: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none,node-name=drv0
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'drv0',
+                          'devices': ["drv0"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'drv0',
+                          'devices': ["drv0"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-(qemu) info snapshots
-List of snapshots present on all disks:
+Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none,node-name=drv0
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'drv0',
+                          'devices': ["drv0"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'drv0',
+                          'devices': ["drv0"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
+Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
---      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
-(qemu) loadvm snap0
-(qemu) quit
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none -device virtio-blk,drive=none0
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-(qemu) info snapshots
-List of snapshots present on all disks:
+Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none,node-name=drv0 -device virtio-blk,drive=none0
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'drv0',
+                          'devices': ["drv0"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'drv0',
+                          'devices': ["drv0"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
+Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
---      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
-(qemu) loadvm snap0
-(qemu) quit
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 
 
 === -drive if=virtio ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Testing: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=virtio
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-Error: Device 'virtio0' is writable but does not support snapshots
-(qemu) info snapshots
-Error: no block device can store vmstate for snapshot
-(qemu) loadvm snap0
-Error: Device 'virtio0' is writable but does not support snapshots
-(qemu) quit
+Testing: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=virtio,node-name=drv0
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'drv0',
+                          'devices': ["drv0"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'drv0',
+                          'devices': ["drv0"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
-Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=virtio
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-(qemu) info snapshots
-List of snapshots present on all disks:
+Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=virtio,node-name=drv0
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'drv0',
+                          'devices': ["drv0"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'drv0',
+                          'devices': ["drv0"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
+Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
---      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
-(qemu) loadvm snap0
-(qemu) quit
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 
 
 === Simple -blockdev ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-Error: Device 'file' is writable but does not support snapshots
-(qemu) info snapshots
-Error: no block device can store vmstate for snapshot
-(qemu) loadvm snap0
-Error: Device 'file' is writable but does not support snapshots
-(qemu) quit
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'file',
+                          'devices': ["file"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'file',
+                          'devices': ["file"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,node-name=fmt
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-(qemu) info snapshots
-List of snapshots present on all disks:
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'fmt',
+                          'devices': ["fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'fmt',
+                          'devices': ["fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
+Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
---      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
-(qemu) loadvm snap0
-(qemu) quit
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=raw,file=file,node-name=raw -blockdev driver=IMGFMT,file=raw,node-name=fmt
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-(qemu) info snapshots
-List of snapshots present on all disks:
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'fmt',
+                          'devices': ["fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'fmt',
+                          'devices': ["fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
+Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
---      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
-(qemu) loadvm snap0
-(qemu) quit
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 
 
 === -blockdev with a filter on top ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,node-name=fmt -blockdev driver=copy-on-read,file=fmt,node-name=filter
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-(qemu) info snapshots
-List of snapshots present on all disks:
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'fmt',
+                          'devices': ["fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'fmt',
+                          'devices': ["fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
+Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
---      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
-(qemu) loadvm snap0
-(qemu) quit
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 
 
 === -blockdev with a backing file ===
@@ -130,25 +306,65 @@ ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
 Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-file,node-name=fmt
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-(qemu) info snapshots
-List of snapshots present on all disks:
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'fmt',
+                          'devices': ["fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'fmt',
+                          'devices': ["fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
+Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
---      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
-(qemu) loadvm snap0
-(qemu) quit
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
 Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=IMGFMT,file=backing-file,node-name=backing-fmt -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-fmt,node-name=fmt
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm snap0
-(qemu) info snapshots
-List of snapshots present on all disks:
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'fmt',
+                          'devices': ["fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'fmt',
+                          'devices': ["fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
+Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
---      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
-(qemu) loadvm snap0
-(qemu) quit
+1       snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
 
 Internal snapshots on overlay:
 Snapshot list:
@@ -159,18 +375,39 @@ Internal snapshots on backing file:
 === -blockdev with NBD server on the backing file ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
-Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=IMGFMT,file=backing-file,node-name=backing-fmt -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-fmt,node-name=fmt
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) nbd_server_start unix:SOCK_DIR/nbd
-(qemu) nbd_server_add -w backing-fmt
-(qemu) savevm snap0
-(qemu) info snapshots
-List of snapshots present on all disks:
-ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
---      snap0                SIZE yyyy-mm-dd hh:mm:ss  0000:00:00.000         --
-(qemu) loadvm snap0
-(qemu) quit
-
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'nbd-server-start',
+       'arguments': { 'addr': { 'type': 'unix',
+                                'data': { 'path': 'SOCK_DIR/nbd' } } } }
+{"return": {}}
+{ 'execute': 'nbd-server-add',
+       'arguments': { 'device': 'backing-fmt', 'writable': true } }
+{"return": {}}
+{ 'execute': 'snapshot-save',
+       'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                      'vmstate': 'fmt',
+                      'devices': ["fmt", "backing-fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'snapshot-load',
+       'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                      'vmstate': 'fmt',
+                      'devices': ["fmt", "backing-fmt"] } }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "backing-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save0"}}
+{"return": {}}
 Internal snapshots on overlay:
 Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT

-- 
2.56.0.rc0.29.g47ce80527c56


