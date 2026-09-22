Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9922C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9730-0002yl-L2; Tue, 22 Sep 2026 16:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971b-0006pQ-SB
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971Z-0000QB-Rq
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oy+CIlG/adbBU7+GU1hko0NnzX2P2hlt0YDFKgcMYe4=;
 b=YP9Bkis0oVdfPT6tYjBAGZ6VaqJxXWBZOi03FKt2YYiJfUerr7G44HIXT2csngbn0AUa1J
 3CUvXaMjaz6oIt0GIJknL+tjSHzpz4d02qRsVJpzYIDC/Y2jIznOuudIZ5Sfez5ibxrlzZ
 QO/1HC6k5lJbdZ2pVzr+DuSBGPS5TUc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-Qs_C4FsXNyqLUiM4dIIx-w-1; Tue,
 22 Sep 2026 16:23:31 -0400
X-MC-Unique: Qs_C4FsXNyqLUiM4dIIx-w-1
X-Mimecast-MFC-AGG-ID: Qs_C4FsXNyqLUiM4dIIx-w_1790108611
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9A7F180059C; Tue, 22 Sep 2026 20:23:30 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 136E01953941; Tue, 22 Sep 2026 20:23:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:20 +0400
Subject: [PATCH 73/88] qemu-iotests/068: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-73-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5585;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7kjpW7gWnWMHvsIKI0iwQ6zfC9EZSudtcb7aHFR23Xs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKz4clK5zGPVPlBPEIAxJOz83f5CUaDDQcVA
 Nwjk5ldB7mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5XgWEACPiVpjNTUL4yNGr6x+8H73x427jI9UqvxgmcDvzqU3mGKS5R60j7NhAei0LN6fwwZQqPy
 xiKHMyfTudfLztNtr+3HyJ7UwAZJ/VO49efc77O6SOZ9KZcXeUc6DcvhBEXtbB/YCBWDMeVcZVu
 +G5He2X5uQw//LkxTyPEAz1eF5HUTsmyf2ON0RiQVo5FlFMRjtElzIbYGRre1kChGqcFhLLTeXA
 fQ7lCJqOBjvMOwizqDHVumgSuz2ilWDbhctpBxsnSJLWbEpyo7cFORYvpzs1iEwXToTWPuFXgh/
 BpHm4oGBgy5HRV9StrvdgzgRtmUV8dxAFOaUkqs7cxDBTO4AWpZaaEzoijPWpD8bTJNv5y5GqrB
 vcwvQI7aHlxhzF25fXiwLD7fjHLhILUiG0jLpJAOTYrrj0gXx6DBMIQTl6t0TFbg6qE7iH+SjGY
 V77TwaFP6YROMSEl+Vmx37kvjzeoj5JvfSSrsT8JMBzRMJN85idZwnitNSFIjUNOtjlOaARk5bn
 9Egwv4MwC9INMhy2GKSPdBVa+9lXnbz27IDZ0l7BRvPFDPqHFwuYyYhwMq+PV+I/hSPm3LaTTuH
 S9eWEoWnQwzByvYmrDKiK7Qk31H9c3mt/t45W6cs739KYoz4KmH9rnVjKcMLYZO2TdzvmrJfne7
 RSPbS1GD7MMytQg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Replace HMP savevm/loadvm with QMP snapshot-save/snapshot-load
job-based API. Use _run_qmp_job() helper to factor the common
send/wait/dismiss pattern.

The sleep before sending commands is no longer needed: the QMP
qmp_capabilities handshake is synchronous, so QEMU is guaranteed
to be ready.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/068     | 56 ++++++++++++++++++++++++++++++++++------------
 tests/qemu-iotests/068.out | 26 ++++++++++-----------
 2 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/tests/qemu-iotests/068 b/tests/qemu-iotests/068
index 11b660a8b7c4..0b756862c1c3 100755
--- a/tests/qemu-iotests/068
+++ b/tests/qemu-iotests/068
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
 
 # This tests qcow2-specific low-level functionality
 _supported_fmt qcow2
@@ -43,7 +45,6 @@ _supported_proto generic
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'compat=0.10' 'refcount_bits=1[^0-9]' data_file
-_require_hmp
 
 IMG_SIZE=128K
 
@@ -56,16 +57,6 @@ case "$QEMU_DEFAULT_MACHINE" in
       ;;
 esac
 
-_qemu()
-{
-    $QEMU $platform_parm -nographic -monitor stdio -serial none \
-          -drive if=none,id=drive0,file="$TEST_IMG",format="$IMGFMT" \
-          -device virtio-scsi,id=hba0 \
-          -device scsi-hd,drive=drive0 \
-          "$@" |\
-    _filter_qemu | _filter_hmp
-}
-
 for extra_args in \
     "" \
     "-object iothread,id=iothread0 -set device.hba0.iothread=iothread0"; do
@@ -75,10 +66,47 @@ for extra_args in \
 
     _make_test_img $IMG_SIZE
 
-    # Give qemu some time to boot before saving the VM state
-    { sleep 1; printf "savevm 0\nquit\n"; } | _qemu $extra_args
+    # Save VM state
+    _launch_qemu $platform_parm \
+          -drive if=none,id=drive0,node-name=disk0,file="$TEST_IMG",format="$IMGFMT" \
+          -device virtio-scsi,id=hba0 \
+          -device scsi-hd,drive=drive0 \
+          $extra_args
+    silent=yes _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'qmp_capabilities' }" \
+        'return'
+    silent=yes _run_qmp_job $QEMU_HANDLE 'save0' \
+        "{ 'execute': 'snapshot-save',
+           'arguments': { 'job-id': 'save0',
+                          'tag': '0',
+                          'vmstate': 'disk0',
+                          'devices': ['disk0'] } }"
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'quit' }" \
+        'return'
+    wait=1 _cleanup_qemu
+
     # Now try to continue from that VM state (this should just work)
-    { sleep 1; printf "loadvm 0\nloadvm 0\nquit\n"; } | _qemu $extra_args -S
+    _launch_qemu $platform_parm \
+          -drive if=none,id=drive0,node-name=disk0,file="$TEST_IMG",format="$IMGFMT" \
+          -device virtio-scsi,id=hba0 \
+          -device scsi-hd,drive=drive0 \
+          -S $extra_args
+    silent=yes _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'qmp_capabilities' }" \
+        'return'
+    for i in 1 2; do
+        silent=yes _run_qmp_job $QEMU_HANDLE "load$i" \
+            "{ 'execute': 'snapshot-load',
+               'arguments': { 'job-id': 'load$i',
+                              'tag': '0',
+                              'vmstate': 'disk0',
+                              'devices': ['disk0'] } }"
+    done
+    _send_qemu_cmd $QEMU_HANDLE \
+        "{ 'execute': 'quit' }" \
+        'return'
+    wait=1 _cleanup_qemu
 done
 
 # success, all done
diff --git a/tests/qemu-iotests/068.out b/tests/qemu-iotests/068.out
index f07a938a3838..3bc0b5a771db 100644
--- a/tests/qemu-iotests/068.out
+++ b/tests/qemu-iotests/068.out
@@ -3,22 +3,20 @@ QA output created by 068
 === Saving and reloading a VM state to/from a qcow2 image () ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm 0
-(qemu) quit
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) loadvm 0
-(qemu) loadvm 0
-(qemu) quit
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 
 === Saving and reloading a VM state to/from a qcow2 image (-object iothread,id=iothread0 -set device.hba0.iothread=iothread0) ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=131072
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) savevm 0
-(qemu) quit
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) loadvm 0
-(qemu) loadvm 0
-(qemu) quit
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


