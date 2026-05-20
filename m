Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DE0CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:52:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPopZ-0003NP-AQ; Wed, 20 May 2026 17:51:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopX-0003C6-V3
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopV-0004e9-B4
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2kxyCfqcdW8J97BihJGOEfbJd+XcaIHswgXj1K0ZftQ=;
 b=CtKh8r6/nTnNvOMmqyEk7/M39WuBhPUHB/1KF+1hZ0CqcNTdTHjB5SgdwHyvKoPRiHvHXP
 dnE7Vt0u7c3wzxhU0dAyf47veCHKGQbEtZgz1DaJJy/jGV44sWuBI0tjZCMXfg0tPLvdMg
 Or4zmYjvAGomL+g/A4v2jH6/XXRbVu8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-TTkhfpYDPJWbwdDbaLYrsQ-1; Wed,
 20 May 2026 17:51:51 -0400
X-MC-Unique: TTkhfpYDPJWbwdDbaLYrsQ-1
X-Mimecast-MFC-AGG-ID: TTkhfpYDPJWbwdDbaLYrsQ_1779313910
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 546D7180061D
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:51:50 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B5471800357; Wed, 20 May 2026 21:51:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:18 +0400
Subject: [PATCH 17/40] tests/qemu-iotests/181, 192, 249: convert to QMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-17-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11592;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TKYDQFrviMWTTW7fOJIEpLbLgZZhdKe9SzfIKlZ95sU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDiGCB9Cga9B2PPGzeVDxPGrhgIKm+MDxLT
 i3CDpaaZBGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5TgBEACL77wPWgtHzkcb85CqW+LcmALGu7c/DGDHpR8cdBM60gQxj5jqO4754BSNiqyO0URyIVi
 EDqTfC8l56A+Kg/1Idt/qQtQtsVx6ir+sCFVonKHsDcIU4jG4fw6nIs7gtr1XmowqZnLtEEi9R5
 iy6Cz/h4T3D/GjLhjCHf2dT6EDE4Gi1fovz5R8fjrpeRSJqtc9OwFVEWUh+RwvGmp8mrhSBsqqJ
 GsH+VaLLq7rRPQaAv8agBAMuYzPqW4Gx731JUjgMCOHZbcYcCLCIo3zidZOyIR3MOMUM9fZY1Ti
 ZoyX+zxEcAzdlrivUlE2gHbJZY7gbU40E6knnWEju2HkgEcn/X1LCqCkFrSEKwNTxiTjqyyCHXr
 GfDSe4YDTTY2/odJHuEZlWMlUWN64DIHGymlK4ZMHPXBZoVfjDtm+bv8YZU2YtryavQL28quGTk
 YP/0DNjXMdbc5+Yxjv+yhMfSGCoIiMQE9xZS+bOn0vp6j+tKX2ESq5A0WpPml54bpuRG7Ba7o7P
 RFsEiKzyezQ6bkcuPkyDa76VybpFFr8D7mKEVS4qwlaiur/yAdXCNVAhNXMO1zeku1XJzaKXMnS
 5GilY6ev303YYF+HjP6s5tXDgF6gNhHNbNzoAXc/QWlRKd9bbEzNwfvPJXVG8l/Antcu/XcvI27
 gJVapcUSlFyNw/w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Convert tests 181 and 192 from HMP monitor commands to QMP:

- Remove qemu_comm_method="monitor" and add qmp_capabilities
  negotiation.
- Replace HMP commands (qemu-io, migrate_set_capability,
  migrate_set_parameter, migrate, info migrate, nbd_server_start,
  nbd_server_add, quit) with their QMP equivalents (x-qemu-io,
  migrate-set-capabilities, migrate-set-parameters, migrate,
  query-migrate, nbd-server-start, nbd-server-add, quit).

Unlike human-monitor-command which wraps errors inside
{"return": "Error: ..."}, x-qemu-io returns errors as a proper QMP
{"error": ...} response. Match 'return\|error' on x-qemu-io calls so
the test terminates on both success and failure, rather than hanging
until timeout. Apply the same fix to test 249.

Remove the HMP output drain idiom (send empty command, wait for
prompt) after query-migrate polling in test 181. In QMP, an empty line
produces no response, so this would hang.

Capture the RESUME event delivered on the destination QMP channel after
postcopy migration completes. This event was not visible in HMP mode.

Update expected output for all three tests.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/181     | 99 ++++++++++++++++++++++++++++++++++------------
 tests/qemu-iotests/181.out | 36 ++++++++++++-----
 tests/qemu-iotests/192     | 22 +++++++++--
 tests/qemu-iotests/192.out | 17 ++++++--
 tests/qemu-iotests/249     |  6 +--
 5 files changed, 134 insertions(+), 46 deletions(-)

diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index dc90a10757f..3de24090c68 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -55,8 +55,6 @@ echo
 echo === Starting VMs ===
 echo
 
-qemu_comm_method="monitor"
-
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     _launch_qemu \
         -drive "${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,id=disk
@@ -77,15 +75,30 @@ else
 fi
 dest=$QEMU_HANDLE
 
+_send_qemu_cmd $src \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+_send_qemu_cmd $dest \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
 echo
 echo === Write something on the source ===
 echo
 
 silent=
-_send_qemu_cmd $src 'qemu-io disk "write -P 0x55 0 64k"' "(qemu)"
-_send_qemu_cmd $src "" "ops/sec"
-_send_qemu_cmd $src 'qemu-io disk "read -P 0x55 0 64k"' "(qemu)"
-_send_qemu_cmd $src "" "ops/sec"
+_send_qemu_cmd $src \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk',
+                      'command': 'write -P 0x55 0 64k' } }" \
+    'return\|error'
+
+_send_qemu_cmd $src \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk',
+                      'command': 'read -P 0x55 0 64k' } }" \
+    'return\|error'
 
 echo
 echo === Do postcopy migration to destination ===
@@ -95,28 +108,49 @@ echo
 # switch to postcopy
 # Enable postcopy-ram capability both on source and destination
 silent=yes
-_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu)"
-
 qemu_error_no_exit=yes success_or_failure=yes \
-    _send_qemu_cmd $dest '' "(qemu)" "Postcopy is not supported"
-if [ ${QEMU_STATUS[$dest]} -lt 0 ]; then
-    _send_qemu_cmd $dest '' "(qemu)"
+    _send_qemu_cmd $dest \
+    "{ 'execute': 'migrate-set-capabilities',
+       'arguments': { 'capabilities': [
+           { 'capability': 'postcopy-ram', 'state': true } ] } }" \
+    'return' 'error'
 
-    _send_qemu_cmd $src 'quit' ""
-    _send_qemu_cmd $dest 'quit' ""
+if [ ${QEMU_STATUS[$dest]} -lt 0 ]; then
+    _send_qemu_cmd $src \
+        "{ 'execute': 'quit' }" \
+        'return'
+    _send_qemu_cmd $dest \
+        "{ 'execute': 'quit' }" \
+        'return'
     wait=1 _cleanup_qemu
 
     _notrun 'Postcopy is not supported'
 fi
 
-_send_qemu_cmd $src 'migrate_set_parameter max-bandwidth 4k' "(qemu)"
-_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
-_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
-_send_qemu_cmd $src 'migrate_start_postcopy' "(qemu)"
+_send_qemu_cmd $src \
+    "{ 'execute': 'migrate-set-parameters',
+       'arguments': { 'max-bandwidth': 4096 } }" \
+    'return'
+
+_send_qemu_cmd $src \
+    "{ 'execute': 'migrate-set-capabilities',
+       'arguments': { 'capabilities': [
+           { 'capability': 'postcopy-ram', 'state': true } ] } }" \
+    'return'
+
+_send_qemu_cmd $src \
+    "{ 'execute': 'migrate',
+       'arguments': { 'uri': 'unix:${MIG_SOCKET}' } }" \
+    'return'
+
+_send_qemu_cmd $src \
+    "{ 'execute': 'migrate-start-postcopy' }" \
+    'return'
 
 QEMU_COMM_TIMEOUT=1 qemu_cmd_repeat=10 silent=yes \
-    _send_qemu_cmd $src "info migrate" "completed\|failed"
-silent=yes _send_qemu_cmd $src "" "(qemu)"
+    _send_qemu_cmd $src \
+    "{ 'execute': 'query-migrate' }" \
+    "completed\|failed"
 
 echo
 echo === Do some I/O on the destination ===
@@ -126,17 +160,32 @@ echo
 # of the node name, which would create a new BlockBackend and not test whether
 # the guest has the necessary permissions to access the image now
 silent=
-_send_qemu_cmd $dest 'qemu-io disk "read -P 0x55 0 64k"' "(qemu)"
-_send_qemu_cmd $dest "" "ops/sec"
-_send_qemu_cmd $dest 'qemu-io disk "write -P 0x66 1M 64k"' "(qemu)"
-_send_qemu_cmd $dest "" "ops/sec"
+capture_events="RESUME"
+_send_qemu_cmd $dest \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk',
+                      'command': 'read -P 0x55 0 64k' } }" \
+    'return\|error'
+capture_events=
+
+_send_qemu_cmd $dest \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk',
+                      'command': 'write -P 0x66 1M 64k' } }" \
+    'return\|error'
 
 echo
 echo === Shut down and check image ===
 echo
 
-_send_qemu_cmd $src 'quit' ""
-_send_qemu_cmd $dest 'quit' ""
+_send_qemu_cmd $src \
+    "{ 'execute': 'quit' }" \
+    'return'
+
+_send_qemu_cmd $dest \
+    "{ 'execute': 'quit' }" \
+    'return'
+
 wait=1 _cleanup_qemu
 
 _check_test_img
diff --git a/tests/qemu-iotests/181.out b/tests/qemu-iotests/181.out
index d58c6a9dabb..ddcce564699 100644
--- a/tests/qemu-iotests/181.out
+++ b/tests/qemu-iotests/181.out
@@ -3,35 +3,51 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 
 === Starting VMs ===
 
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
 
 === Write something on the source ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io disk "write -P 0x55 0 64k"
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk',
+                      'command': 'write -P 0x55 0 64k' } }
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) 
-(qemu) qemu-io disk "read -P 0x55 0 64k"
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk',
+                      'command': 'read -P 0x55 0 64k' } }
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{"return": {}}
 
 === Do postcopy migration to destination ===
 
 
 === Do some I/O on the destination ===
 
-(qemu) qemu-io disk "read -P 0x55 0 64k"
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk',
+                      'command': 'read -P 0x55 0 64k' } }
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) 
-(qemu) qemu-io disk "write -P 0x66 1M 64k"
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk',
+                      'command': 'write -P 0x66 1M 64k' } }
 wrote 65536/65536 bytes at offset 1048576
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{"return": {}}
 
 === Shut down and check image ===
 
-(qemu) quit
-(qemu) 
-(qemu) quit
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
 No errors were found on the image.
 *** done
diff --git a/tests/qemu-iotests/192 b/tests/qemu-iotests/192
index e66e1a4f06a..ea89cffe107 100755
--- a/tests/qemu-iotests/192
+++ b/tests/qemu-iotests/192
@@ -58,7 +58,6 @@ else
     DRIVE_ARG=if=ide,id=drive0,format=$IMGFMT,file=$TEST_IMG
 fi
 
-qemu_comm_method="monitor"
 _launch_qemu -drive $DRIVE_ARG -incoming defer
 h=$QEMU_HANDLE
 if [ "${VALGRIND_QEMU}" == "y" ]; then
@@ -67,9 +66,24 @@ else
     QEMU_COMM_TIMEOUT=1
 fi
 
-_send_qemu_cmd $h "nbd_server_start unix:$SOCK_DIR/nbd" "(qemu)"
-_send_qemu_cmd $h "nbd_server_add -w drive0" "(qemu)"
-_send_qemu_cmd $h "q" "(qemu)"
+_send_qemu_cmd $h \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'nbd-server-start',
+       'arguments': { 'addr': { 'type': 'unix',
+                                'data': { 'path': '$SOCK_DIR/nbd' } } } }" \
+    'return'
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'nbd-server-add',
+       'arguments': { 'device': 'drive0', 'writable': true } }" \
+    'return'
+
+_send_qemu_cmd $h \
+    "{ 'execute': 'quit' }" \
+    'return'
 
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/192.out b/tests/qemu-iotests/192.out
index b9429dbe367..88185a2e8ff 100644
--- a/tests/qemu-iotests/192.out
+++ b/tests/qemu-iotests/192.out
@@ -1,7 +1,16 @@
 QA output created by 192
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) nbd_server_start unix:SOCK_DIR/nbd
-(qemu) nbd_server_add -w drive0
-(qemu) q
+{ 'execute': 'qmp_capabilities' }
+{"return": {}}
+{ 'execute': 'nbd-server-start',
+       'arguments': { 'addr': { 'type': 'unix',
+                                'data': { 'path': 'SOCK_DIR/nbd' } } } }
+{"return": {}}
+{ 'execute': 'nbd-server-add',
+       'arguments': { 'device': 'drive0', 'writable': true } }
+{"return": {}}
+{ 'execute': 'quit' }
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_EXPORT_DELETED", "data": {"id": "drive0"}}
+{"return": {}}
 *** done
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index 16cf6c2d8c4..d30a2ac6bc8 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -69,7 +69,7 @@ echo
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'x-qemu-io',
        'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}" \
-    'return'
+    'return\|error'
 
 echo
 echo '=== Run block-commit on base using an invalid filter node name'
@@ -86,7 +86,7 @@ echo
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'x-qemu-io',
        'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}" \
-    'return'
+    'return\|error'
 
 echo
 echo '=== Run block-commit on base using the default filter node name'
@@ -106,7 +106,7 @@ echo
 _send_qemu_cmd $QEMU_HANDLE \
     "{ 'execute': 'x-qemu-io',
        'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}" \
-    'return'
+    'return\|error'
 
 _cleanup_qemu
 

-- 
2.54.0


