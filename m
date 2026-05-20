Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94681CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:52:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPopW-00033z-S9; Wed, 20 May 2026 17:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopV-0002t0-6i
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPopP-0004cU-QV
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:51:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779313907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1Mue0S2X6VyYUNIZGExwsUa2eSlbjX3q6PRbrp4a54=;
 b=cF7869iWBfWXa/CUT2S604hUJSE4ySgJJisnEMz8kT+duyE1l3yAxXU0Lkdlg8wcX0UjYL
 RklP7p9pvDHhjmiS1SQ1nWgvm9gB03ptYWBLnQL9UkxJ30H+7ek58CFpTCdgivXx2XQcDn
 YJC3kweefxGpkAJJpKkfsyw/GuVhpyk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-HBIb78TdPJCykXBztEbVqg-1; Wed,
 20 May 2026 17:51:45 -0400
X-MC-Unique: HBIb78TdPJCykXBztEbVqg-1
X-Mimecast-MFC-AGG-ID: HBIb78TdPJCykXBztEbVqg_1779313904
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A299F180061B
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:51:44 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AFDD1681; Wed, 20 May 2026 21:51:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:17 +0400
Subject: [PATCH 16/40] tests/qemu-iotests/N: use x-qemu-io QMP command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-16-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=26085;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=W7tBIGjX9jcsMOsJY7Cyoyr/m4noj2riyG8PcEHAjc4=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyDpliVo5W90G9OAOfDYKxiB1tvjNAGobr/o
 FbE3XcDGx6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4sgwAKCRDa6OEJdZac
 5Q7GD/9Ya1T/eeUEh2uLYtphdI9Obv5+Njcmofo131Kw4+vMXIkB71pwE3kPgFtupdhYpIxTLZN
 qNfY08k71waSoAjwft2ml8AXuloDbgxWw/rDViKuzOSLfGlK6nhVvXEbKy5HeSXGrqa4g/ZuODn
 EpFZMu/Xizi2Sj6VM4JzvuQ2M7FblX+csc3N16PUsRaUBvGrMECxn+6UqzI10lljQREV/YyBIO/
 JGPfJJAPmf2HsbSDgr0cXctoAnsw0T3P4UPM//wg1Yw4RpJs/VtF/Nfc40zt1TjCcKlGLEsJgfG
 9lvrhakgkaPAUeIh54/DsBUkUwRytbT9P31Hm+S8b4SAx9yAHppOuU//IPUQySHzVYm4TRGM5kU
 PCkcogaPwnBd9IQcecKcwzZ7SNGoYdzwEQ7UitVmE0h4s4E6lUH+QXsNyrkPkexp7Ro/kx/LvTM
 tho3BxKTbKACVzLUQyV031Bm+NmhCekEtPD9fXNqWxk55yjrXjAa3Dm+tL7MmO7qVeONNwDCeNu
 Oqx+4KFmHSEl3c+7jyURaY+M5LmlcCh1fyKX19+l7QoMB/Qr5NipZujO54cE67Dw5U7EXfF5twg
 fr/Ze5QJGtE8SNdfuWoQJVuCRsFUrUJ0D4hjFtiaxiKbMgf8dkmYdXIJIzRSpSoMydFSob1HJIp
 tnhsZuERWOaldEg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Replace human-monitor-command wrapping of the HMP qemu-io command with
direct x-qemu-io QMP calls in the two test cases that exercised
corrupted image behavior through the monitor.

The only output change is the QMP response: {"return": {}} (void)
instead of {"return": ""} (empty HMP string).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/060     |  8 ++++----
 tests/qemu-iotests/060.out |  2 +-
 tests/qemu-iotests/071     | 30 +++++++++++++++++------------
 tests/qemu-iotests/071.out |  8 ++++----
 tests/qemu-iotests/117     |  5 +++--
 tests/qemu-iotests/117.out |  7 ++++---
 tests/qemu-iotests/120     |  4 ++--
 tests/qemu-iotests/120.out |  2 +-
 tests/qemu-iotests/156     | 36 +++++++++++++++++-----------------
 tests/qemu-iotests/156.out | 48 +++++++++++++++++++++++-----------------------
 tests/qemu-iotests/161     | 18 ++++++++---------
 tests/qemu-iotests/161.out | 24 +++++++++++------------
 tests/qemu-iotests/249     | 12 ++++++------
 tests/qemu-iotests/249.out | 18 ++++++++---------
 tests/qemu-iotests/283     |  4 ++--
 tests/qemu-iotests/283.out |  4 ++--
 16 files changed, 119 insertions(+), 111 deletions(-)

diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
index 5cd21a6f686..c2c1cd815f0 100755
--- a/tests/qemu-iotests/060
+++ b/tests/qemu-iotests/060
@@ -449,8 +449,8 @@ echo
 _make_test_img 64M
 poke_file "$TEST_IMG" "$rt_offset"        "\x00\x00\x00\x00\x00\x00\x00\x00"
 echo "{'execute': 'qmp_capabilities'}
-      {'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io drive \"write 0 512\"'}}
+      {'execute': 'x-qemu-io',
+       'arguments': {'device': 'drive', 'command': 'write 0 512'}}
       {'execute': 'quit'}" \
     | $QEMU -qmp stdio -nographic -nodefaults \
             -drive if=none,node-name=drive,file="$TEST_IMG",driver=qcow2 \
@@ -468,8 +468,8 @@ poke_file "$TEST_IMG" "$l1_offset" "\x00\x00\x00\x00\x2a\x2a\x2a\x2a"
 # Inactive images are effectively read-only images, so this should be a
 # non-fatal corruption (which does not modify the image)
 echo "{'execute': 'qmp_capabilities'}
-      {'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io drive \"read 0 512\"'}}
+      {'execute': 'x-qemu-io',
+       'arguments': {'device': 'drive', 'command': 'read 0 512'}}
       {'execute': 'quit'}" \
     | $QEMU -qmp stdio -nographic -nodefaults \
             -blockdev "{'node-name': 'drive',
diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
index 27275fd6b70..7d3bfc97450 100644
--- a/tests/qemu-iotests/060.out
+++ b/tests/qemu-iotests/060.out
@@ -419,7 +419,7 @@ qcow2: Marking image as corrupt: Preventing invalid write on metadata (overlaps
 QMP_VERSION
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_IMAGE_CORRUPTED", "data": {"device": "none0", "msg": "Preventing invalid write on metadata (overlaps with refcount table)", "offset": 65536, "node-name": "drive", "fatal": true, "size": 65536}}
-{"return": "Error: write failed: Input/output error\r\n"}
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 
diff --git a/tests/qemu-iotests/071 b/tests/qemu-iotests/071
index 331f8cfddcf..463f5c02349 100755
--- a/tests/qemu-iotests/071
+++ b/tests/qemu-iotests/071
@@ -139,9 +139,10 @@ run_qemu <<EOF
         }
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-debug "read 0 512"'
+        "device": "drive0-debug",
+        "command": "read 0 512"
     }
 }
 { "execute": "quit" }
@@ -174,9 +175,10 @@ run_qemu <<EOF
         }
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-verify "read 0 512"'
+        "device": "drive0-verify",
+        "command": "read 0 512"
     }
 }
 { "execute": "quit" }
@@ -209,9 +211,10 @@ run_qemu <<EOF
         "raw": "drive0"
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-verify "read 0 512"'
+        "device": "drive0-verify",
+        "command": "read 0 512"
     }
 }
 { "execute": "quit" }
@@ -248,19 +251,22 @@ run_qemu <<EOF
         }
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-debug "read 0 512"'
+        "device": "drive0-debug",
+        "command": "read 0 512"
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-debug "write 0 512"'
+        "device": "drive0-debug",
+        "command": "write 0 512"
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-debug "read 0 512"'
+        "device": "drive0-debug",
+        "command": "read 0 512"
     }
 }
 { "execute": "quit" }
diff --git a/tests/qemu-iotests/071.out b/tests/qemu-iotests/071.out
index f2d015d8cca..7fcdbed943f 100644
--- a/tests/qemu-iotests/071.out
+++ b/tests/qemu-iotests/071.out
@@ -43,7 +43,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"return": {}}
-{"return": "Error: read failed: Input/output error\r\n"}
+{"error": {"class": "GenericError", "desc": "read failed: Input/output error"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 
@@ -77,11 +77,11 @@ QMP_VERSION
 {"return": {}}
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{"return": {}}
 wrote 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{"return": "Error: read failed: Input/output error\r\n"}
+{"return": {}}
+{"error": {"class": "GenericError", "desc": "read failed: Input/output error"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 QEMU_PROG: Failed to flush the L2 table cache: Input/output error
 QEMU_PROG: Failed to flush the refcount block cache: Input/output error
diff --git a/tests/qemu-iotests/117 b/tests/qemu-iotests/117
index 6081473584f..bbd9d431502 100755
--- a/tests/qemu-iotests/117
+++ b/tests/qemu-iotests/117
@@ -65,8 +65,9 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
 
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'qemu-io format \"write -P 42 0 64k\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'format',
+                      'command': 'write -P 42 0 64k' } }" \
     'return'
 
 _send_qemu_cmd $QEMU_HANDLE \
diff --git a/tests/qemu-iotests/117.out b/tests/qemu-iotests/117.out
index 1cea9e02173..ed260e8215b 100644
--- a/tests/qemu-iotests/117.out
+++ b/tests/qemu-iotests/117.out
@@ -12,11 +12,12 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=65536
                       'driver': 'IMGFMT',
                       'file': 'protocol' } }
 {"return": {}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line': 'qemu-io format "write -P 42 0 64k"' } }
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'format',
+                      'command': 'write -P 42 0 64k' } }
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{"return": {}}
 { 'execute': 'quit' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
diff --git a/tests/qemu-iotests/120 b/tests/qemu-iotests/120
index ac7bd8c4e3c..fb9ac5a165e 100755
--- a/tests/qemu-iotests/120
+++ b/tests/qemu-iotests/120
@@ -46,8 +46,8 @@ _require_drivers raw
 _make_test_img 64M
 
 echo "{'execute': 'qmp_capabilities'}
-      {'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io drv \"write -P 42 0 64k\"'}}
+      {'execute': 'x-qemu-io',
+       'arguments': {'device': 'drv', 'command': 'write -P 42 0 64k'}}
       {'execute': 'quit'}" \
     | $QEMU -qmp stdio -nographic -nodefaults \
             -drive id=drv,if=none,file="$TEST_IMG",driver=raw,file.driver=$IMGFMT \
diff --git a/tests/qemu-iotests/120.out b/tests/qemu-iotests/120.out
index 35d84a5bc5a..e5b8848207d 100644
--- a/tests/qemu-iotests/120.out
+++ b/tests/qemu-iotests/120.out
@@ -4,7 +4,7 @@ QMP_VERSION
 {"return": {}}
 wrote 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 read 65536/65536 bytes at offset 0
diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index 97c2d86ce57..1b0c955c422 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -79,9 +79,9 @@ _send_qemu_cmd $QEMU_HANDLE \
 
 # Write something to the snapshot
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source \"write -P 3 128k 128k\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'write -P 3 128k 128k' } }" \
     'return'
 
 # Create target image
@@ -104,9 +104,9 @@ _send_qemu_cmd $QEMU_HANDLE \
 
 # Write some more
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source \"write -P 4 192k 64k\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'write -P 4 192k 64k' } }" \
     'return'
 
 # Copy source backing chain to the target before completing the job
@@ -133,27 +133,27 @@ echo
 
 # Check online disk contents
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source \"read -P 1 0k 64k\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 1 0k 64k' } }" \
     'return'
 
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source \"read -P 2 64k 64k\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 2 64k 64k' } }" \
     'return'
 
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source \"read -P 3 128k 64k\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 3 128k 64k' } }" \
     'return'
 
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source \"read -P 4 192k 64k\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 4 192k 64k' } }" \
     'return'
 
 echo
diff --git a/tests/qemu-iotests/156.out b/tests/qemu-iotests/156.out
index 07e5e83f5d4..5a3805746a7 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -14,12 +14,12 @@ Formatting 'TEST_DIR/t.IMGFMT.overlay', fmt=IMGFMT size=1048576 backing_file=TES
                       'format': 'IMGFMT',
                       'mode': 'existing' } }
 {"return": {}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "write -P 3 128k 128k"' } }
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'write -P 3 128k 128k' } }
 wrote 131072/131072 bytes at offset 131072
 128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{"return": {}}
 Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.target backing_fmt=IMGFMT
 { 'execute': 'drive-mirror',
        'arguments': { 'device': 'source',
@@ -31,12 +31,12 @@ Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=IMGFMT size=1048576 backing_f
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "source", "len": 131072, "offset": 131072, "speed": 0, "type": "mirror"}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "write -P 4 192k 64k"' } }
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'write -P 4 192k 64k' } }
 wrote 65536/65536 bytes at offset 196608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{"return": {}}
 { 'execute': 'block-job-complete',
        'arguments': { 'device': 'source' } }
 {"return": {}}
@@ -46,30 +46,30 @@ wrote 65536/65536 bytes at offset 196608
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "source"}}
 
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "read -P 1 0k 64k"' } }
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 1 0k 64k' } }
 read 65536/65536 bytes at offset 0
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "read -P 2 64k 64k"' } }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 2 64k 64k' } }
 read 65536/65536 bytes at offset 65536
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "read -P 3 128k 64k"' } }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 3 128k 64k' } }
 read 65536/65536 bytes at offset 131072
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "read -P 4 192k 64k"' } }
+{"return": {}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 4 192k 64k' } }
 read 65536/65536 bytes at offset 196608
 64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{"return": {}}
 
 { 'execute': 'quit' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index f25effab936..0f4d59b97d2 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -64,9 +64,9 @@ _send_qemu_cmd $QEMU_HANDLE \
     'return'
 
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io none0 \"reopen -o backing.detect-zeroes=on\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'none0',
+                      'command': 'reopen -o backing.detect-zeroes=on' } }" \
     "return"
 
 _cleanup_qemu
@@ -92,9 +92,9 @@ _send_qemu_cmd $QEMU_HANDLE \
 sleep 0.5
 
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io none0 \"reopen -o backing.detect-zeroes=on\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'none0',
+                      'command': 'reopen -o backing.detect-zeroes=on' } }" \
     "return"
 
 _cleanup_qemu
@@ -125,9 +125,9 @@ _send_qemu_cmd $QEMU_HANDLE \
 sleep 0.5
 
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io none0 \"reopen -o backing.detect-zeroes=on\"' } }" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'none0',
+                      'command': 'reopen -o backing.detect-zeroes=on' } }" \
     "return"
 
 _cleanup_qemu
diff --git a/tests/qemu-iotests/161.out b/tests/qemu-iotests/161.out
index 6cc285afcfd..0975bc288bf 100644
--- a/tests/qemu-iotests/161.out
+++ b/tests/qemu-iotests/161.out
@@ -7,10 +7,10 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 { 'execute': 'qmp_capabilities' }
 {"return": {}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io none0 "reopen -o backing.detect-zeroes=on"' } }
-{"return": ""}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'none0',
+                      'command': 'reopen -o backing.detect-zeroes=on' } }
+{"return": {}}
 
 *** Stream and then change an option on the backing file
 
@@ -21,15 +21,15 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "none0"}}
 {"return": {}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io none0 "reopen -o backing.detect-zeroes=on"' } }
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'none0',
+                      'command': 'reopen -o backing.detect-zeroes=on' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "none0", "len": 1048576, "offset": 1048576, "speed": 0, "type": "stream"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "none0"}}
-{"return": ""}
+{"return": {}}
 
 *** Commit and then change an option on the backing file
 
@@ -43,13 +43,13 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "none0"}}
 {"return": {}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io none0 "reopen -o backing.detect-zeroes=on"' } }
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'none0',
+                      'command': 'reopen -o backing.detect-zeroes=on' } }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "none0", "len": 1048576, "offset": 1048576, "speed": 0, "type": "commit"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "none0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "none0"}}
-{"return": ""}
+{"return": {}}
 *** done
diff --git a/tests/qemu-iotests/249 b/tests/qemu-iotests/249
index 28bffd4d571..16cf6c2d8c4 100755
--- a/tests/qemu-iotests/249
+++ b/tests/qemu-iotests/249
@@ -67,8 +67,8 @@ echo
 echo '=== Send a write command to a drive opened in read-only mode (1)'
 echo
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}}" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}" \
     'return'
 
 echo
@@ -84,8 +84,8 @@ echo
 echo '=== Send a write command to a drive opened in read-only mode (2)'
 echo
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}}" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}" \
     'return'
 
 echo
@@ -104,8 +104,8 @@ echo
 echo '=== Send a write command to a drive opened in read-only mode (3)'
 echo
 _send_qemu_cmd $QEMU_HANDLE \
-    "{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 \"aio_write 0 2k\"'}}" \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}" \
     'return'
 
 _cleanup_qemu
diff --git a/tests/qemu-iotests/249.out b/tests/qemu-iotests/249.out
index 3d37709a9ef..79f69cd2651 100644
--- a/tests/qemu-iotests/249.out
+++ b/tests/qemu-iotests/249.out
@@ -7,9 +7,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 === Send a write command to a drive opened in read-only mode (1)
 
-{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 "aio_write 0 2k"'}}
-{"return": "Error: Block node is read-onlyrn"}
+{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}
+{"error": {"class": "GenericError", "desc": "Block node is read-only"}}
 
 === Run block-commit on base using an invalid filter node name
 
@@ -22,9 +22,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 === Send a write command to a drive opened in read-only mode (2)
 
-{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 "aio_write 0 2k"'}}
-{"return": "Error: Block node is read-onlyrn"}
+{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}
+{"error": {"class": "GenericError", "desc": "Block node is read-only"}}
 
 === Run block-commit on base using the default filter node name
 
@@ -41,7 +41,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 
 === Send a write command to a drive opened in read-only mode (3)
 
-{ 'execute': 'human-monitor-command',
-       'arguments': {'command-line': 'qemu-io none0 "aio_write 0 2k"'}}
-{"return": "Error: Block node is read-onlyrn"}
+{ 'execute': 'x-qemu-io',
+       'arguments': {'device': 'none0', 'command': 'aio_write 0 2k'}}
+{"error": {"class": "GenericError", "desc": "Block node is read-only"}}
 *** done
diff --git a/tests/qemu-iotests/283 b/tests/qemu-iotests/283
index 5defe48e97d..655a2113341 100755
--- a/tests/qemu-iotests/283
+++ b/tests/qemu-iotests/283
@@ -136,8 +136,8 @@ vm.event_wait('BLOCK_JOB_COMPLETED', 5.0)
 # The filter should be gone now.  Check that by trying to access it
 # with qemu-io (which will most likely crash qemu if it is still
 # there.).
-vm.qmp_log('human-monitor-command',
-           command_line='qemu-io backup-filter "write 0 1M"')
+vm.qmp_log('x-qemu-io',
+           device='backup-filter', command='write 0 1M')
 
 # (Also, do an explicit check.)
 assert vm.node_info('backup-filter') is None
diff --git a/tests/qemu-iotests/283.out b/tests/qemu-iotests/283.out
index 5e4f456db55..1c12c8fad7d 100644
--- a/tests/qemu-iotests/283.out
+++ b/tests/qemu-iotests/283.out
@@ -17,7 +17,7 @@
 {"return": {}}
 {"execute": "job-finalize", "arguments": {"id": "backup"}}
 {"return": {}}
-{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io backup-filter \"write 0 1M\""}}
-{"return": "Error: Cannot find device='' nor node-name='backup-filter'\r\n"}
+{"execute": "x-qemu-io", "arguments": {"command": "write 0 1M", "device": "backup-filter"}}
+{"error": {"class": "GenericError", "desc": "Cannot find device='' nor node-name='backup-filter'"}}
 {"execute": "job-dismiss", "arguments": {"id": "backup"}}
 {"return": {}}

-- 
2.54.0


