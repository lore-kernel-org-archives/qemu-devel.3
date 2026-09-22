Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688BBC98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971h-0007JX-6o; Tue, 22 Sep 2026 16:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971N-0005Dg-3z
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971J-0000Nn-UU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I2Wto5I1yX1IKX5Ovkzu3+N/o/mNbQWnan+kBGT5b14=;
 b=Aq/UpkNwu2LhuUAwRQvzgYEGp4/XniSYUxpJgEtrLMLyGObsvFwobtAXKKhzlregfez0OQ
 Z3N2EipqVgccsfX92cuXcI9KtvzZz5KnxfwTipXbTZ+Ipgi+PtxQ645b9/VrFiC9/atbSi
 kIIiPk2zw4yghg3snpy+2c4sz8FDQDs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-Q7jHbFHEPx-v44s0ABcP-Q-1; Tue,
 22 Sep 2026 16:23:14 -0400
X-MC-Unique: Q7jHbFHEPx-v44s0ABcP-Q-1
X-Mimecast-MFC-AGG-ID: Q7jHbFHEPx-v44s0ABcP-Q_1790108593
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D1F7193E884; Tue, 22 Sep 2026 20:23:13 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 102D441B; Tue, 22 Sep 2026 20:23:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:15 +0400
Subject: [PATCH 68/88] qemu-iotests/qcow2-internal-snapshots: migrate away
 from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-68-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=21484;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=IYWVaRlfRYajDS8Idms9CE3zZ1Ei8rFCLdCh/+yQ6p0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzk0f6v/V13yIwqAGwCPG0A5F88WmCp4XV5
 PAwukCotTuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5WliD/wLYJwNJbnHUR+96n29R0wAoHLkUaYopvI7MU471tqdGbvituli7El90VYhPyZzmncIbRo
 bJJW7PLbp6oZy6T1MopiwJnmWxOHbbK0NRg58RbEKF02/uNa0MKTy0A0l0Oy0JL9g+J4aq8CTOn
 /4oJf0pR8MRa4bzQLR/xQf4+Gxe12NsrSlU7E6CWNy6YbuOZLkdM7kSC5OuJRIfq0/hQxnDFvbQ
 A0DOAE9EN8fkdR6Dy42a1OgeWicuRcXpbTvAVn3eKXyHnUdruOfw1dhhMYKw5Bpjrd51tCkAgPX
 xNLkUBEcX1DMy28tHQhQAdo9WqemsrR2yrnFLE5Pta+3EnSI+/O1oF21BYMdQJEDcdl+z5SsHte
 Cq5yjXER9lA3DRBwI+EcNUFRgl7HjMA4w1yuEmagb1cI/+lTnK/BUoIqnBJcUHlj2xxvNHp3ph2
 5WHcj7+t6rJ+QUAPY6K/0O/662b8nnMkdjxX6KQY+Z83SJRbD9U3Bma0843pMquJ7DejwnWL5ca
 pfwFjiUnT4OHmjnXDLG+NWBdLNGZ8FZj9U5sqDdWEBloXSQiQDr8RC5qoL5EjqYo1mDlonoPsXE
 s5d0wH8nViuCXQCSQiYYgBqnMc+JwLkCSEyZDp4A4dcRuErp6k+SbJL/cjUKnjRA8SPrQ6p6Anm
 KTbmTzHKwiB+2Ow==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Replace the HMP-based test infrastructure with QMP using common.qemu.

The old _qemu() function piped HMP commands (savevm, loadvm, delvm,
qemu-io) through a monitor stdio pipe. Replace it with interactive QMP
control via _launch_qemu / _send_qemu_cmd, using the job-based QMP
commands snapshot-save, snapshot-load, and snapshot-delete.

These snapshot commands use the JOB_MANUAL_DISMISS flag, so jobs
remain in the "concluded" state until explicitly dismissed. The test
handles this through two helpers:

- _do_snapshot_cmd(): captures noisy QMP events (JOB_STATUS_CHANGE,
  STOP, RESUME) during the snapshot operation, silently waits for the
  job to reach "concluded", then dismisses it with job-dismiss.

- _do_snapshot_error(): same flow, but before dismissing, queries the
  concluded job with query-jobs to retrieve the error message. This
  preserves the error verification that HMP provided natively through
  its text output.

I/O operations use x-qemu-io via _do_qemu_io(). CLI error cases
(e.g. conflicting -loadvm with -incoming defer or -preconfig) invoke
QEMU directly with stderr redirected, since those errors are emitted
before QMP is available.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/qcow2-internal-snapshots  | 226 +++++++++++++++------
 .../tests/qcow2-internal-snapshots.out             | 175 ++++++++++------
 2 files changed, 284 insertions(+), 117 deletions(-)

diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots b/tests/qemu-iotests/tests/qcow2-internal-snapshots
index d301f0941b5c..3d6da93e6931 100755
--- a/tests/qemu-iotests/tests/qcow2-internal-snapshots
+++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots
@@ -29,13 +29,16 @@ status=1	# failure is the default!
 
 _cleanup()
 {
+	_cleanup_qemu
 	_cleanup_test_img
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
 # get standard environment, filters and checks
-. ../common.rc
-. ../common.filter
+cd ..
+. ./common.rc
+. ./common.filter
+. ./common.qemu
 
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
@@ -43,20 +46,78 @@ _supported_proto file
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'compat=0.10' 'refcount_bits=1[^0-9]' data_file
-_require_hmp
 
 IMG_SIZE=64M
 
-_qemu()
+QEMU_ARGS="-no-shutdown -nodefaults \
+    -blockdev file,filename=$TEST_IMG,node-name=disk0-file \
+    -blockdev $IMGFMT,file=disk0-file,node-name=disk0 \
+    -object iothread,id=iothread0 \
+    -device virtio-scsi,iothread=iothread0 \
+    -device scsi-hd,drive=disk0,share-rw=on"
+
+_do_qemu_io()
 {
-    $QEMU -no-shutdown -nographic -monitor stdio -serial none \
-          -blockdev file,filename="$TEST_IMG",node-name=disk0-file \
-          -blockdev "$IMGFMT",file=disk0-file,node-name=disk0 \
-          -object iothread,id=iothread0 \
-          -device virtio-scsi,iothread=iothread0 \
-          -device scsi-hd,drive=disk0,share-rw=on \
-          "$@" 2>&1 |\
-    _filter_qemu | _filter_hmp | _filter_qemu_io
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': '$1' } }" \
+        'return'
+}
+
+_do_snapshot_cmd()
+{
+    local cmd="$1" job_id="$2"
+    capture_events="JOB_STATUS_CHANGE STOP RESUME" \
+    _send_qemu_cmd $QEMU_HANDLE "$cmd" 'return'
+    silent=yes _send_qemu_cmd $QEMU_HANDLE '' '"concluded"'
+    silent=yes capture_events="JOB_STATUS_CHANGE" \
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'job-dismiss',
+           'arguments': { 'id': '$job_id' } }" \
+        'return'
+}
+
+_do_snapshot_save()
+{
+    _do_snapshot_cmd \
+        "{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': '$2', 'tag': '$1',
+                          'vmstate': 'disk0',
+                          'devices': [\"disk0\"] } }" "$2"
+}
+
+_do_snapshot_load()
+{
+    _do_snapshot_cmd \
+        "{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': '$2', 'tag': '$1',
+                          'vmstate': 'disk0',
+                          'devices': [\"disk0\"] } }" "$2"
+}
+
+_do_snapshot_delete()
+{
+    _do_snapshot_cmd \
+        "{ 'execute': 'snapshot-delete',
+           'arguments': { 'job-id': '$2', 'tag': '$1',
+                          'devices': [\"disk0\"] } }" "$2"
+}
+
+_do_snapshot_error()
+{
+    local cmd="$1" job_id="$2"
+    capture_events="JOB_STATUS_CHANGE STOP RESUME" \
+    _send_qemu_cmd $QEMU_HANDLE "$cmd" 'return'
+    silent=yes _send_qemu_cmd $QEMU_HANDLE '' '"concluded"'
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'query-jobs' }" \
+        'return'
+    silent=yes capture_events="JOB_STATUS_CHANGE" \
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'job-dismiss',
+           'arguments': { 'id': '$job_id' } }" \
+        'return'
 }
 
 _make_test_img $IMG_SIZE
@@ -65,14 +126,16 @@ echo
 echo "=== Write some data, take a snapshot and overwrite part of it ==="
 echo
 
-{
-    echo 'qemu-io disk0 "write -P0x11 0 1M"'
-    # Give qemu some time to boot before saving the VM state
-    sleep 0.5
-    echo "savevm snap0"
-    echo 'qemu-io disk0 "write -P0x22 0 512k"'
-    echo "quit"
-} | _qemu
+_launch_qemu $QEMU_ARGS
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" 'return'
+
+_do_qemu_io "write -P0x11 0 1M"
+_do_snapshot_save snap0 save0
+_do_qemu_io "write -P0x22 0 512k"
+
+capture_events="JOB_STATUS_CHANGE SHUTDOWN" \
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'quit' }" 'return'
+wait=1 _cleanup_qemu
 
 echo
 $QEMU_IMG snapshot -l "$TEST_IMG" | _filter_date | _filter_vmstate_size
@@ -82,26 +145,29 @@ echo
 echo "=== Verify that loading the snapshot reverts to the old content ==="
 echo
 
-{
-    # -loadvm reverted the write from the previous QEMU instance
-    echo 'qemu-io disk0 "read -P0x11 0 1M"'
+# -loadvm reverts the write from the previous QEMU instance
+_launch_qemu $QEMU_ARGS -loadvm snap0
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" 'return'
 
-    # Verify that it works without restarting QEMU, too
-    echo 'qemu-io disk0 "write -P0x33 512k 512k"'
-    echo "loadvm snap0"
-    echo 'qemu-io disk0 "read -P0x11 0 1M"'
+_do_qemu_io "read -P0x11 0 1M"
 
-    # Verify COW by writing a partial cluster
-    echo 'qemu-io disk0 "write -P0x33 63k 2k"'
-    echo 'qemu-io disk0 "read -P0x11 0 63k"'
-    echo 'qemu-io disk0 "read -P0x33 63k 2k"'
-    echo 'qemu-io disk0 "read -P0x11 65k 63k"'
+# Verify that it works without restarting QEMU, too
+_do_qemu_io "write -P0x33 512k 512k"
+_do_snapshot_load snap0 load0
+_do_qemu_io "read -P0x11 0 1M"
 
-    # Take a second snapshot
-    echo "savevm snap1"
+# Verify COW by writing a partial cluster
+_do_qemu_io "write -P0x33 63k 2k"
+_do_qemu_io "read -P0x11 0 63k"
+_do_qemu_io "read -P0x33 63k 2k"
+_do_qemu_io "read -P0x11 65k 63k"
 
-    echo "quit"
-} | _qemu -loadvm snap0
+# Take a second snapshot
+_do_snapshot_save snap1 save1
+
+capture_events="JOB_STATUS_CHANGE SHUTDOWN" \
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'quit' }" 'return'
+wait=1 _cleanup_qemu
 
 echo
 $QEMU_IMG snapshot -l "$TEST_IMG" | _filter_date | _filter_vmstate_size
@@ -123,15 +189,19 @@ $QEMU_IO \
 echo
 echo "=== Deleting snapshots ==="
 echo
-{
-    # The active layer stays unaffected by deleting the snapshot
-    echo "delvm snap1"
-    echo 'qemu-io disk0 "read -P0x11 0 63k"'
-    echo 'qemu-io disk0 "read -P0x33 63k 2k"'
-    echo 'qemu-io disk0 "read -P0x11 65k 63k"'
 
-    echo "quit"
-} | _qemu
+_launch_qemu $QEMU_ARGS
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" 'return'
+
+# The active layer stays unaffected by deleting the snapshot
+_do_snapshot_delete snap1 del0
+_do_qemu_io "read -P0x11 0 63k"
+_do_qemu_io "read -P0x33 63k 2k"
+_do_qemu_io "read -P0x11 65k 63k"
+
+capture_events="JOB_STATUS_CHANGE SHUTDOWN" \
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'quit' }" 'return'
+wait=1 _cleanup_qemu
 
 
 echo
@@ -143,27 +213,69 @@ echo "=== Error cases ==="
 echo
 
 # snap1 should not exist any more
-_qemu -loadvm snap1
+$QEMU -no-shutdown -nographic -serial none -nodefaults \
+    -blockdev file,filename="$TEST_IMG",node-name=disk0-file \
+    -blockdev "$IMGFMT",file=disk0-file,node-name=disk0 \
+    -object iothread,id=iothread0 \
+    -device virtio-scsi,iothread=iothread0 \
+    -device scsi-hd,drive=disk0,share-rw=on \
+    -loadvm snap1 2>&1 | _filter_qemu
 
 echo
-{
-    echo "loadvm snap1"
-    echo "quit"
-} | _qemu
+_launch_qemu $QEMU_ARGS
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" 'return'
+_do_snapshot_error \
+    "{ 'execute': 'snapshot-load',
+       'arguments': { 'job-id': 'load1', 'tag': 'snap1',
+                      'vmstate': 'disk0',
+                      'devices': [\"disk0\"] } }" load1
+capture_events="JOB_STATUS_CHANGE SHUTDOWN" \
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'quit' }" 'return'
+wait=1 _cleanup_qemu
 
 # Snapshot operations and inactive images are incompatible
 echo
-_qemu -loadvm snap0 -incoming defer
-{
-    echo "loadvm snap0"
-    echo "delvm snap0"
-    echo "savevm snap1"
-    echo "quit"
-} | _qemu -incoming defer
+$QEMU -no-shutdown -nographic -serial none -nodefaults \
+    -blockdev file,filename="$TEST_IMG",node-name=disk0-file \
+    -blockdev "$IMGFMT",file=disk0-file,node-name=disk0 \
+    -object iothread,id=iothread0 \
+    -device virtio-scsi,iothread=iothread0 \
+    -device scsi-hd,drive=disk0,share-rw=on \
+    -loadvm snap0 -incoming defer 2>&1 | _filter_qemu
+
+_launch_qemu $QEMU_ARGS -incoming defer
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'qmp_capabilities' }" 'return'
+
+_do_snapshot_error \
+    "{ 'execute': 'snapshot-load',
+       'arguments': { 'job-id': 'load2', 'tag': 'snap0',
+                      'vmstate': 'disk0',
+                      'devices': [\"disk0\"] } }" load2
+
+_do_snapshot_error \
+    "{ 'execute': 'snapshot-delete',
+       'arguments': { 'job-id': 'del2', 'tag': 'snap0',
+                      'devices': [\"disk0\"] } }" del2
+
+_do_snapshot_error \
+    "{ 'execute': 'snapshot-save',
+       'arguments': { 'job-id': 'save2', 'tag': 'snap1',
+                      'vmstate': 'disk0',
+                      'devices': [\"disk0\"] } }" save2
+
+capture_events="JOB_STATUS_CHANGE SHUTDOWN" \
+_send_qemu_cmd $QEMU_HANDLE "{ 'execute': 'quit' }" 'return'
+wait=1 _cleanup_qemu
 
 # -loadvm and -preconfig are incompatible
 echo
-_qemu -loadvm snap0 -preconfig
+$QEMU -no-shutdown -nographic -serial none -nodefaults \
+    -blockdev file,filename="$TEST_IMG",node-name=disk0-file \
+    -blockdev "$IMGFMT",file=disk0-file,node-name=disk0 \
+    -object iothread,id=iothread0 \
+    -device virtio-scsi,iothread=iothread0 \
+    -device scsi-hd,drive=disk0,share-rw=on \
+    -loadvm snap0 -preconfig 2>&1 | _filter_qemu
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
index fedb09224ea4..fb602505553b 100644
--- a/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
+++ b/tests/qemu-iotests/tests/qcow2-internal-snapshots.out
@@ -3,15 +3,23 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 
 === Write some data, take a snapshot and overwrite part of it ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io disk0 "write -P0x11 0 1M"
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) savevm snap0
-(qemu) qemu-io disk0 "write -P0x22 0 512k"
-wrote 524288/524288 bytes at offset 0
-512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'write -P0x11 0 1M' } }
+{"return": {"human-readable-text": "wrote 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0', 'tag': 'snap0',
+                          'vmstate': 'disk0',
+                          'devices': ["disk0"] } }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'write -P0x22 0 512k' } }
+{"return": {"human-readable-text": "wrote 524288/524288 bytes at offset 0\n512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'quit' }
+{"return": {}}
 
 Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
@@ -20,31 +28,48 @@ No errors were found on the image.
 
 === Verify that loading the snapshot reverts to the old content ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io disk0 "read -P0x11 0 1M"
-read 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) qemu-io disk0 "write -P0x33 512k 512k"
-wrote 524288/524288 bytes at offset 524288
-512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) loadvm snap0
-(qemu) qemu-io disk0 "read -P0x11 0 1M"
-read 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) qemu-io disk0 "write -P0x33 63k 2k"
-wrote 2048/2048 bytes at offset 64512
-2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) qemu-io disk0 "read -P0x11 0 63k"
-read 64512/64512 bytes at offset 0
-63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) qemu-io disk0 "read -P0x33 63k 2k"
-read 2048/2048 bytes at offset 64512
-2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) qemu-io disk0 "read -P0x11 65k 63k"
-read 64512/64512 bytes at offset 66560
-63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) savevm snap1
-(qemu) quit
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'read -P0x11 0 1M' } }
+{"return": {"human-readable-text": "read 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'write -P0x33 512k 512k' } }
+{"return": {"human-readable-text": "wrote 524288/524288 bytes at offset 524288\n512 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'snapshot-load',
+           'arguments': { 'job-id': 'load0', 'tag': 'snap0',
+                          'vmstate': 'disk0',
+                          'devices': ["disk0"] } }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'read -P0x11 0 1M' } }
+{"return": {"human-readable-text": "read 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'write -P0x33 63k 2k' } }
+{"return": {"human-readable-text": "wrote 2048/2048 bytes at offset 64512\n2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'read -P0x11 0 63k' } }
+{"return": {"human-readable-text": "read 64512/64512 bytes at offset 0\n63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'read -P0x33 63k 2k' } }
+{"return": {"human-readable-text": "read 2048/2048 bytes at offset 64512\n2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'read -P0x11 65k 63k' } }
+{"return": {"human-readable-text": "read 64512/64512 bytes at offset 66560\n63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save1', 'tag': 'snap1',
+                          'vmstate': 'disk0',
+                          'devices': ["disk0"] } }
+{"return": {}}
+{ 'execute': 'quit' }
+{"return": {}}
 
 Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
@@ -65,18 +90,26 @@ read 64512/64512 bytes at offset 66560
 
 === Deleting snapshots ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) delvm snap1
-(qemu) qemu-io disk0 "read -P0x11 0 63k"
-read 64512/64512 bytes at offset 0
-63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) qemu-io disk0 "read -P0x33 63k 2k"
-read 2048/2048 bytes at offset 64512
-2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) qemu-io disk0 "read -P0x11 65k 63k"
-read 64512/64512 bytes at offset 66560
-63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-delete',
+           'arguments': { 'job-id': 'del0', 'tag': 'snap1',
+                          'devices': ["disk0"] } }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'read -P0x11 0 63k' } }
+{"return": {"human-readable-text": "read 64512/64512 bytes at offset 0\n63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'read -P0x33 63k 2k' } }
+{"return": {"human-readable-text": "read 2048/2048 bytes at offset 64512\n2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'x-qemu-io',
+           'arguments': { 'device': 'disk0',
+                          'command': 'read -P0x11 65k 63k' } }
+{"return": {"human-readable-text": "read 64512/64512 bytes at offset 66560\n63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'quit' }
+{"return": {}}
 
 Snapshot list:
 ID      TAG               VM_SIZE                DATE        VM_CLOCK     ICOUNT
@@ -85,23 +118,45 @@ No errors were found on the image.
 
 === Error cases ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) QEMU_PROG: Snapshot 'snap1' does not exist in one or more devices
+QEMU_PROG: Snapshot 'snap1' does not exist in one or more devices
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) loadvm snap1
-Error: Snapshot 'snap1' does not exist in one or more devices
-(qemu) quit
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-load',
+       'arguments': { 'job-id': 'load1', 'tag': 'snap1',
+                      'vmstate': 'disk0',
+                      'devices': ["disk0"] } }
+{"return": {}}
+{ 'execute': 'query-jobs' }
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load1", "error": "Snapshot 'snap1' does not exist in one or more devices"}]}
+{ 'execute': 'quit' }
+{"return": {}}
 
 QEMU_PROG: 'incoming' and 'loadvm' options are mutually exclusive
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) loadvm snap0
-Error: Device 'disk0' is writable but does not support snapshots
-(qemu) delvm snap0
-Error: Device 'disk0' is writable but does not support snapshots
-(qemu) savevm snap1
-Error: Device 'disk0' is writable but does not support snapshots
-(qemu) quit
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'snapshot-load',
+       'arguments': { 'job-id': 'load2', 'tag': 'snap0',
+                      'vmstate': 'disk0',
+                      'devices': ["disk0"] } }
+{"return": {}}
+{ 'execute': 'query-jobs' }
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load2", "error": "Device 'disk0' is writable but does not support snapshots"}]}
+{ 'execute': 'snapshot-delete',
+       'arguments': { 'job-id': 'del2', 'tag': 'snap0',
+                      'devices': ["disk0"] } }
+{"return": {}}
+{ 'execute': 'query-jobs' }
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "del2", "error": "Device 'disk0' is writable but does not support snapshots"}]}
+{ 'execute': 'snapshot-save',
+       'arguments': { 'job-id': 'save2', 'tag': 'snap1',
+                      'vmstate': 'disk0',
+                      'devices': ["disk0"] } }
+{"return": {}}
+{ 'execute': 'query-jobs' }
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "save2", "error": "Device 'disk0' is writable but does not support snapshots"}]}
+{ 'execute': 'quit' }
+{"return": {}}
 
 QEMU_PROG: 'preconfig' and 'loadvm' options are mutually exclusive
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


