Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FB08C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:25:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971i-0007dR-Sv; Tue, 22 Sep 2026 16:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971F-0004NR-CU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971C-0000MZ-Ud
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNFsWAWEhHIJ5jUFvwTQtIHMMPmtQKR6pPx0HRGHhSo=;
 b=OUHLPgkPkOJpS4fC6ixPQCyXHsoFzXoXlkVFctU1jyiEFswhDANEuSK6yguiDwAhyjGa5d
 W6VwDNhJcKajGvSkh2393Qn2UqrIGAI0D30ETb090F1NsvEz6vtZyu7jBNDBIAzjSC94y+
 AVfLnZna9lfoF3TEvmnsnU37mh/MNtY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-VNSaQvKwOVKLVkRGgEf4LA-1; Tue,
 22 Sep 2026 16:23:06 -0400
X-MC-Unique: VNSaQvKwOVKLVkRGgEf4LA-1
X-Mimecast-MFC-AGG-ID: VNSaQvKwOVKLVkRGgEf4LA_1790108586
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E103119541A2; Tue, 22 Sep 2026 20:23:05 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DBE8F1800446; Tue, 22 Sep 2026 20:23:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:13 +0400
Subject: [PATCH 66/88] qemu-iotests/write-zeroes-unmap: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-66-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=10082;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xC1fJrUZ5TXEOinN+weJqJyH+fiyZ3y9gZxOj9L795E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKyvVLcmV1mrmy2MKsVj0CP5t4MgCLY/we0w
 aRNn+wnKrmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5UfPD/9K2GcH62CRV68Pc7mIGC1aXD5SEIzcQhCbjhuwyOu73NWnRutY9AIo0Q79yTmVTZHxM4t
 tMCuBPwUhT2HjvvY0e3tebMtCB8cKMqck62EVpgxMIWUXPhzwLXgVZRGjwymgZLTr7giO3S3ETo
 VeC6mcNAazH1erg9gv6sITaiILJuWuXMCPrYeWupJGKYXsiswMbauIAuU+5B1Zbfx4vtsyQX6T3
 FNbyiN0rQahM0g7R9CAsQn5I37PLMsWwwb6m0Q3ui1IydmQuZK5/Ua5S0tk1RcQLovB5E7Nocv9
 cs39MTD4qvSwAgLOW/Ps/jdRKY/EDMLQojdUZjeCnVNbeX3u2Px90Pp85XSi8SyX+4zTxl8j94v
 2FXUvh8NrcW68iy/1Wmex00FNa03hRf414+wuhz3GczUk9JyWzBBdWxCoe20DPyElwM9bIE0Esi
 PB93gJMJozWdm3MiEu1pAG4Q2uDRpm4mp9OvmjkJNoDAfuFcamJxyeMSxG243g+ndeKidEF4WNp
 khCENJItHVgdUtRrTUNhHBL6bgEIrtYYT+fuyAASSPFcgBvVFHKdDvnf9YhWsiDdUVZHlnys5Ef
 CrqwAsSrkz5MRMZg4t1TouNLUjmGqTKxicecqXVSk4G/Gpj7cCEBRdkG9IdO93ZP89PGH6mjjj2
 o8dZ/BBj8phKVig==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Introduce qmp_qemu_io() to help with sending just one x-qemu-io command.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/write-zeroes-unmap     | 42 +++++++------
 tests/qemu-iotests/tests/write-zeroes-unmap.out | 80 ++++++++++++-------------
 2 files changed, 64 insertions(+), 58 deletions(-)

diff --git a/tests/qemu-iotests/tests/write-zeroes-unmap b/tests/qemu-iotests/tests/write-zeroes-unmap
index 506ced647bc1..b5c019c85acf 100755
--- a/tests/qemu-iotests/tests/write-zeroes-unmap
+++ b/tests/qemu-iotests/tests/write-zeroes-unmap
@@ -33,27 +33,33 @@ _supported_fmt raw
 _supported_proto file
 _supported_os Linux
 _require_disk_usage
-_require_hmp
 
 create_test_image() {
     _make_test_img -f $IMGFMT 1m
 }
 
 filter_command() {
-    _filter_testdir | _filter_qemu_io | _filter_qemu | _filter_hmp
+    _filter_qmp | _filter_testdir | _filter_qemu_io | _filter_qemu
 }
 
 print_disk_usage() {
     du -sh $TEST_IMG | _filter_testdir
 }
 
+qmp_qemu_io() {
+    printf '%s\n' \
+        '{"execute":"qmp_capabilities"}' \
+        "{\"execute\":\"x-qemu-io\",\"arguments\":{\"device\":\"none0\",\"command\":\"$1\"}}" \
+        '{"execute":"quit"}'
+}
+
 echo
 echo "=== defaults - write zeros ==="
 echo
 
 create_test_image
-echo -e 'qemu-io none0 "write -z 0 1m"\nquit' \
-    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT \
+qmp_qemu_io "write -z 0 1m" \
+    | $QEMU -qmp stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT \
     | filter_command
 print_disk_usage
 
@@ -62,8 +68,8 @@ echo "=== defaults - write zeros unmap ==="
 echo
 
 create_test_image
-echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' \
-    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT \
+qmp_qemu_io "write -zu 0 1m" \
+    | $QEMU -qmp stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT \
     | filter_command
 print_disk_usage
 
@@ -73,8 +79,8 @@ echo "=== defaults - write actual zeros ==="
 echo
 
 create_test_image
-echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' \
-    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT \
+qmp_qemu_io "write -P 0 0 1m" \
+    | $QEMU -qmp stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT \
     | filter_command
 print_disk_usage
 
@@ -83,8 +89,8 @@ echo "=== discard=off - write zeroes unmap ==="
 echo
 
 create_test_image
-echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' \
-    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,discard=off \
+qmp_qemu_io "write -zu 0 1m" \
+    | $QEMU -qmp stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,discard=off \
     | filter_command
 print_disk_usage
 
@@ -93,8 +99,8 @@ echo "=== detect-zeroes=on - write actual zeros ==="
 echo
 
 create_test_image
-echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' \
-    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,detect-zeroes=on \
+qmp_qemu_io "write -P 0 0 1m" \
+    | $QEMU -qmp stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,detect-zeroes=on \
     | filter_command
 print_disk_usage
 
@@ -103,8 +109,8 @@ echo "=== detect-zeroes=on,discard=on - write actual zeros ==="
 echo
 
 create_test_image
-echo -e 'qemu-io none0 "write -P 0 0 1m"\nquit' \
-    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,detect-zeroes=on,discard=on \
+qmp_qemu_io "write -P 0 0 1m" \
+    | $QEMU -qmp stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,detect-zeroes=on,discard=on \
     | filter_command
 print_disk_usage
 
@@ -113,8 +119,8 @@ echo "=== discard=on - write zeroes ==="
 echo
 
 create_test_image
-echo -e 'qemu-io none0 "write -z 0 1m"\nquit' \
-    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,discard=on \
+qmp_qemu_io "write -z 0 1m" \
+    | $QEMU -qmp stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,discard=on \
     | filter_command
 print_disk_usage
 
@@ -123,7 +129,7 @@ echo "=== discard=on - write zeroes unmap ==="
 echo
 
 create_test_image
-echo -e 'qemu-io none0 "write -zu 0 1m"\nquit' \
-    | $QEMU -monitor stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,discard=on \
+qmp_qemu_io "write -zu 0 1m" \
+    | $QEMU -qmp stdio -drive if=none,file=$TEST_IMG,format=$IMGFMT,discard=on \
     | filter_command
 print_disk_usage
diff --git a/tests/qemu-iotests/tests/write-zeroes-unmap.out b/tests/qemu-iotests/tests/write-zeroes-unmap.out
index c9319948976f..1ac940a8badc 100644
--- a/tests/qemu-iotests/tests/write-zeroes-unmap.out
+++ b/tests/qemu-iotests/tests/write-zeroes-unmap.out
@@ -3,79 +3,79 @@ QA output created by write-zeroes-unmap
 === defaults - write zeros ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io none0 "write -z 0 1m"
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": {"human-readable-text": "wrote 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 1.0M	TEST_DIR/t.raw
 
 === defaults - write zeros unmap ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io none0 "write -zu 0 1m"
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": {"human-readable-text": "wrote 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 1.0M	TEST_DIR/t.raw
 
 === defaults - write actual zeros ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io none0 "write -P 0 0 1m"
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": {"human-readable-text": "wrote 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 1.0M	TEST_DIR/t.raw
 
 === discard=off - write zeroes unmap ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io none0 "write -zu 0 1m"
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": {"human-readable-text": "wrote 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 1.0M	TEST_DIR/t.raw
 
 === detect-zeroes=on - write actual zeros ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io none0 "write -P 0 0 1m"
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": {"human-readable-text": "wrote 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 1.0M	TEST_DIR/t.raw
 
 === detect-zeroes=on,discard=on - write actual zeros ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io none0 "write -P 0 0 1m"
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": {"human-readable-text": "wrote 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 1.0M	TEST_DIR/t.raw
 
 === discard=on - write zeroes ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io none0 "write -z 0 1m"
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": {"human-readable-text": "wrote 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 1.0M	TEST_DIR/t.raw
 
 === discard=on - write zeroes unmap ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io none0 "write -zu 0 1m"
-wrote 1048576/1048576 bytes at offset 0
-1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) quit
+QMP_VERSION
+{"return": {}}
+{"return": {"human-readable-text": "wrote 1048576/1048576 bytes at offset 0\n1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 0	TEST_DIR/t.raw

-- 
2.56.0.rc0.29.g47ce80527c56


