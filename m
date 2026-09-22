Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8C2C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9725-0000VQ-GT; Tue, 22 Sep 2026 16:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971s-00005x-IQ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971q-0000TK-5u
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7s1YoYdM1i9DUeQaJXKr4O1KGACtaLK3E1rwLt0mq9Q=;
 b=M1VyUHovnctJ1sYK9/iivB0V0yyXGuvV9sfHLUh0d448RgMpdpTKbsB/QDx41joCXZYROC
 WU7l000VHUMESEW1739+mKdnuZJJjwXzEankTWxKhXA/eUjk328r5UtVPFo1BWUP0nmC22
 FjblledJWdAYFgXQxh8noMptt9hS+sY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-4n0YV8XyOp6wbdzh3dp8eg-1; Tue,
 22 Sep 2026 16:23:46 -0400
X-MC-Unique: 4n0YV8XyOp6wbdzh3dp8eg-1
X-Mimecast-MFC-AGG-ID: 4n0YV8XyOp6wbdzh3dp8eg_1790108625
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C11F1955E86; Tue, 22 Sep 2026 20:23:45 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B08D1800370; Tue, 22 Sep 2026 20:23:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:24 +0400
Subject: [PATCH 77/88] qemu-iotests/181: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-77-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=7500;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rqJ4WMDQ6kwxskRAsn1ltEAO5ZsJQAzxuAKDK46OEhQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKzF61b5xIhjC0VAhfu5GW6O5yB6JegYeTol
 0LHyekrRGmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLiswAKCRDa6OEJdZac
 5WoAD/9UtjdG1xl208WxMEd9MNVhto1cssMIv1oTTEXubDscrStZk6k9mKrETvUiDfrM6uFyvE3
 ETIcFPOuP9wUWAaUytPSK1LpPFiAAxaW2xA2wt2PA75ROX4z7KD3K6vWgNFpVSfy2s8myv5qX3G
 WX51CgrcvQ1qSkOw19AWoa1scvW9/3pSCB3MGrl/1r8ys+ACmvINqlYHRgXszX3UmYEgoTlnKVe
 HZlhT8ur6dWtsJtAnds1zGoRStADd4sKFKeseZM8zV/RLOAgtz1KQtSnHUN92ws/jcyiY+fK1uh
 SFLD76e83AcDeVZ8jdSo1qQi9BxmsQxpkBk5WrMfoT4SB8UtI5jxCI0pOwrk24gr5TmPG1tGN34
 upggGZY7DjK5Qyzug+/FxHZ1PLAQkuYfjBnyWJHLTT60X1yJX+LeLPiB3tPVlvKH/ULEs/dDeVQ
 X/wDIZ6sICsUwoMGQfLDu1zr+Rf3dEvEgB/+FkYelE75e8FcALy0RxrE1AY/f+e++3tV2fh+ycP
 BaIJjwJR6ig+wNIeFb3KAG6fiYMujicYgV8bkMe3JAG9ILdbxnQD84EJiekUfbp5h2QDr3KnQbA
 diEYWcxA8jNlJpCHUy9S3uUePhu70MRtZf/fWiJArqjyYEiqD+ARm6X0+cFYZigyc9HvapUZ+QV
 7ifdgKwiyeo2gMw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Replace HMP migration and savevm/loadvm commands with QMP equivalents.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/181     | 86 ++++++++++++++++++++++++++++++++--------------
 tests/qemu-iotests/181.out | 36 +++++++++----------
 2 files changed, 78 insertions(+), 44 deletions(-)

diff --git a/tests/qemu-iotests/181 b/tests/qemu-iotests/181
index 458cb737f1cb..d814a1b8226e 100755
--- a/tests/qemu-iotests/181
+++ b/tests/qemu-iotests/181
@@ -47,7 +47,6 @@ _supported_fmt generic
 _unsupported_fmt qcow vdi vhdx vmdk vpc vvfat parallels
 _supported_proto generic
 _supported_os Linux
-_require_hmp
 
 _flaky_test https://gitlab.com/qemu-project/qemu/-/work_items/3515
 
@@ -58,8 +57,6 @@ echo
 echo === Starting VMs ===
 echo
 
-qemu_comm_method="monitor"
-
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     _launch_qemu \
         -drive "${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,id=disk
@@ -80,15 +77,27 @@ else
 fi
 dest=$QEMU_HANDLE
 
+silent=yes
+_send_qemu_cmd $src \
+    "{ 'execute': 'qmp_capabilities' }" \
+    'return'
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
+       'arguments': { 'device': 'disk', 'command': 'write -P 0x55 0 64k' } }" \
+    'return'
+_send_qemu_cmd $src \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk', 'command': 'read -P 0x55 0 64k' } }" \
+    'return'
 
 echo
 echo === Do postcopy migration to destination ===
@@ -98,28 +107,45 @@ echo
 # switch to postcopy
 # Enable postcopy-ram capability both on source and destination
 silent=yes
-_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu)"
-
 qemu_error_no_exit=yes success_or_failure=yes \
-    _send_qemu_cmd $dest '' "(qemu)" "Postcopy is not supported"
+    _send_qemu_cmd $dest \
+    "{ 'execute': 'migrate-set-capabilities',
+       'arguments': { 'capabilities': [
+           { 'capability': 'postcopy-ram', 'state': true } ] } }" \
+    'return' 'error'
 if [ ${QEMU_STATUS[$dest]} -lt 0 ]; then
-    _send_qemu_cmd $dest '' "(qemu)"
-
-    _send_qemu_cmd $src 'quit' ""
-    _send_qemu_cmd $dest 'quit' ""
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
+_send_qemu_cmd $src \
+    "{ 'execute': 'migrate-set-capabilities',
+       'arguments': { 'capabilities': [
+           { 'capability': 'postcopy-ram', 'state': true } ] } }" \
+    'return'
+_send_qemu_cmd $src \
+    "{ 'execute': 'migrate',
+       'arguments': { 'uri': 'unix:${MIG_SOCKET}' } }" \
+    'return'
+_send_qemu_cmd $src \
+    "{ 'execute': 'migrate-start-postcopy' }" \
+    'return'
 
 QEMU_COMM_TIMEOUT=1 qemu_cmd_repeat=10 silent=yes \
-    _send_qemu_cmd $src "info migrate" "completed\|failed"
-silent=yes _send_qemu_cmd $src "" "(qemu)"
+    _send_qemu_cmd $src \
+    "{ 'execute': 'query-migrate' }" \
+    '"status": "completed"\|"status": "failed"'
 
 echo
 echo === Do some I/O on the destination ===
@@ -129,17 +155,25 @@ echo
 # of the node name, which would create a new BlockBackend and not test whether
 # the guest has the necessary permissions to access the image now
 silent=
-_send_qemu_cmd $dest 'qemu-io disk "read -P 0x55 0 64k"' "(qemu)"
-_send_qemu_cmd $dest "" "ops/sec"
-_send_qemu_cmd $dest 'qemu-io disk "write -P 0x66 1M 64k"' "(qemu)"
-_send_qemu_cmd $dest "" "ops/sec"
+_send_qemu_cmd $dest \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk', 'command': 'read -P 0x55 0 64k' } }" \
+    'return'
+_send_qemu_cmd $dest \
+    "{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk', 'command': 'write -P 0x66 1M 64k' } }" \
+    'return'
 
 echo
 echo === Shut down and check image ===
 echo
 
-_send_qemu_cmd $src 'quit' ""
-_send_qemu_cmd $dest 'quit' ""
+_send_qemu_cmd $src \
+    "{ 'execute': 'quit' }" \
+    'return'
+_send_qemu_cmd $dest \
+    "{ 'execute': 'quit' }" \
+    'return'
 wait=1 _cleanup_qemu
 
 _check_test_img
diff --git a/tests/qemu-iotests/181.out b/tests/qemu-iotests/181.out
index d58c6a9dabb0..43dc83bc9cae 100644
--- a/tests/qemu-iotests/181.out
+++ b/tests/qemu-iotests/181.out
@@ -6,32 +6,32 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 
 === Write something on the source ===
 
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) qemu-io disk "write -P 0x55 0 64k"
-wrote 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) 
-(qemu) qemu-io disk "read -P 0x55 0 64k"
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk', 'command': 'write -P 0x55 0 64k' } }
+{"return": {"human-readable-text": "wrote 65536/65536 bytes at offset 0n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)n"}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk', 'command': 'read -P 0x55 0 64k' } }
+{"return": {"human-readable-text": "read 65536/65536 bytes at offset 0n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)n"}}
 
 === Do postcopy migration to destination ===
 
 
 === Do some I/O on the destination ===
 
-(qemu) qemu-io disk "read -P 0x55 0 64k"
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-(qemu) 
-(qemu) qemu-io disk "write -P 0x66 1M 64k"
-wrote 65536/65536 bytes at offset 1048576
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk', 'command': 'read -P 0x55 0 64k' } }
+{"return": {"human-readable-text": "read 65536/65536 bytes at offset 0n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)n"}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'disk', 'command': 'write -P 0x66 1M 64k' } }
+{"return": {"human-readable-text": "wrote 65536/65536 bytes at offset 1048576n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)n"}}
 
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

-- 
2.56.0.rc0.29.g47ce80527c56


