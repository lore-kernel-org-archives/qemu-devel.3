Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C302C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9749-0004MA-Kk; Tue, 22 Sep 2026 16:26:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x972B-0000oi-7M
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9727-0000Ye-Jy
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:24:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LP8XCX5ASRsqA4OG+3UZ8Qu3Ks/FKYKqG2r9J83gIoE=;
 b=HsfWi69uHr7BbdGmisuETop1FtkFhhqNUvFwy/1rwCeqcB1presxPZMMs9kvkETMbVWpDK
 RfrXlZpr4NURQuGpHpJfrOElnRMsjuK5YH73+kbM4BTEE7TEvIMiEThmpkdVY6hrhvW6Pl
 2l5H5LQiQjjayTIXXy9oRyeuQsM6Vvw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-qb8V35DNO_OewSgP-VGA4w-1; Tue,
 22 Sep 2026 16:24:00 -0400
X-MC-Unique: qb8V35DNO_OewSgP-VGA4w-1
X-Mimecast-MFC-AGG-ID: qb8V35DNO_OewSgP-VGA4w_1790108639
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C81E819541A5; Tue, 22 Sep 2026 20:23:59 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9740041D; Tue, 22 Sep 2026 20:23:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:28 +0400
Subject: [PATCH 81/88] qemu-iotests/201: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-81-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5955;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=0bp6tqAl3jxpTfegHU87ohdT+lbG4Pc2Re4usS/nCyY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuK01KY3ClsYVbvD0Xgn2+cVI9tPoNRmyTtm2
 MqWO+FHASuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLitAAKCRDa6OEJdZac
 5aL0D/kBx641MWl4VyVSemh0tPuPXAv0cvYIX+bnHlY8/mx2RODGU+Cew7SoAawhlNMgLsVntXR
 AYSXu+qxFapCCJ3T5deh9BCGRDVcxYWpMZDL+wXsiKc/7NlVRUuwvfU+cyVqRCLxVOAqMGovOVr
 8xoz1cNsPsMovAB+nn1qz2HW41oGH2owV4xhoqFXKNZxfYH0Qz9eazAqOgTMHrLc6cGnu0nA1X1
 tdTsOUE2To9nlskxZsckhAHLtB0TT0oQmA651fwsNEca3s3UsiX5TzVKJFnP7OtqaMmq5tuPeGT
 QfAsDJx4vCGiyy3njbqqzVmkrgcLop7FF7w2spklRT6/cOIf8m8XRpGUQYpFZo+qBDsGTGNmwNv
 icS5qKzTTOggRVbso9rbihDWu8jQq64GN+sqbRNAs7Gzo1Dg602hoFCgHZKweBZzR+pLnClG4RX
 re84Yw7gNBf3Af+OuD4CD4piuyhzIH2YqgAk6y/gVG+6AlGs1MWkpm84l+Wp3aF1/U9E3bo8ik5
 YlT8m4V7z7fkYRRGkyQ33TcuMlbSsmtguq0zUibN69nEOz5XQ6RV2UJ+oTqf8H5U+rCG99u5wn9
 2egDSLWXndStbw1gW6qtap93utumCab3vOplQsZM4fP0zyVTH4N3jVKRInWGjCKClfi6s97pzbV
 Q6vcC/c+ZRO0ktQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Replace HMP migration and savevm/loadvm commands with QMP equivalents.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/201     | 75 +++++++++++++++++++++++++++++-----------------
 tests/qemu-iotests/201.out | 10 ++++---
 2 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/tests/qemu-iotests/201 b/tests/qemu-iotests/201
index a5c750c38a83..302ad983d83d 100755
--- a/tests/qemu-iotests/201
+++ b/tests/qemu-iotests/201
@@ -47,7 +47,6 @@ _supported_os Linux
 # Internal snapshots are (currently) impossible with refcount_bits=1,
 # and generally impossible with external data files
 _unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
-_require_hmp
 
 size=64M
 _make_test_img $size
@@ -56,76 +55,96 @@ echo
 echo === Starting VMs ===
 echo
 
-qemu_comm_method="monitor"
-
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,id=disk
+        -drive "${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,id=disk,node-name=disk0
 else
     _launch_qemu \
-        -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,driver=$IMGFMT,id=disk
+        -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,driver=$IMGFMT,id=disk,node-name=disk0
 fi
 src=$QEMU_HANDLE
+silent=yes _send_qemu_cmd $src "{ 'execute': 'qmp_capabilities' }" 'return'
 
 if [ "$IMGOPTSSYNTAX" = "true" ]; then
     _launch_qemu \
-        -drive "${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,id=disk \
+        -drive "${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,id=disk,node-name=disk0 \
         -incoming "unix:${MIG_SOCKET}"
 else
     _launch_qemu \
-        -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,driver=$IMGFMT,id=disk \
+        -drive file="${TEST_IMG}",cache=${CACHEMODE},aio=$AIOMODE,driver=$IMGFMT,id=disk,node-name=disk0 \
         -incoming "unix:${MIG_SOCKET}"
 fi
 dest=$QEMU_HANDLE
+silent=yes _send_qemu_cmd $dest "{ 'execute': 'qmp_capabilities' }" 'return'
 
 echo
 echo === Set \'migrate_set_capability postcopy-ram on\' and migrate ===
 echo
 
-silent=yes
-_send_qemu_cmd $dest 'migrate_set_capability postcopy-ram on' "(qemu)"
-
-qemu_error_no_exit=yes success_or_failure=yes \
-    _send_qemu_cmd $dest '' "(qemu)" "Postcopy is not supported"
+silent=yes qemu_error_no_exit=yes success_or_failure=yes \
+    _send_qemu_cmd $dest \
+        "{ 'execute': 'migrate-set-capabilities',
+           'arguments': { 'capabilities': [
+               { 'capability': 'postcopy-ram', 'state': true }
+           ] } }" \
+        'return' "Postcopy is not supported"
 if [ ${QEMU_STATUS[$dest]} -lt 0 ]; then
-    _send_qemu_cmd $dest '' "(qemu)"
-
-    _send_qemu_cmd $src 'quit' ""
-    _send_qemu_cmd $dest 'quit' ""
+    _send_qemu_cmd $src "{ 'execute': 'quit' }" 'return'
+    _send_qemu_cmd $dest "{ 'execute': 'quit' }" 'return'
     wait=1 _cleanup_qemu
-
     _notrun 'Postcopy is not supported'
 fi
 
-_send_qemu_cmd $src 'migrate_set_capability postcopy-ram on' "(qemu)"
-_send_qemu_cmd $src "migrate -d unix:${MIG_SOCKET}" "(qemu)"
+silent=yes _send_qemu_cmd $src \
+    "{ 'execute': 'migrate-set-capabilities',
+       'arguments': { 'capabilities': [
+           { 'capability': 'postcopy-ram', 'state': true }
+       ] } }" \
+    'return'
+
+silent=yes _send_qemu_cmd $src \
+    "{ 'execute': 'migrate',
+       'arguments': { 'uri': 'unix:${MIG_SOCKET}' } }" \
+    'return'
 
 QEMU_COMM_TIMEOUT=1 qemu_cmd_repeat=10 silent=yes \
-    _send_qemu_cmd $src "info migrate" "completed\|failed"
-silent=yes _send_qemu_cmd $src "" "(qemu)"
+    _send_qemu_cmd $src \
+        "{ 'execute': 'query-migrate' }" \
+        '"completed"\|"failed"'
 
 echo
 echo === Check if migration was successful ===
 echo
 
 QEMU_COMM_TIMEOUT=1 silent=yes \
-    _send_qemu_cmd $src "info migrate" "completed"
-silent=yes _send_qemu_cmd $src "" "(qemu)"
+    _send_qemu_cmd $src \
+        "{ 'execute': 'query-migrate' }" \
+        '"completed"'
 
 echo
 echo === On destination, execute savevm and loadvm ===
 echo
 
-silent=
-_send_qemu_cmd $dest 'savevm state1' "(qemu)"
-_send_qemu_cmd $dest 'loadvm state1' "(qemu)"
+silent=yes _run_qmp_job $dest 'save0' \
+    "{ 'execute': 'snapshot-save',
+       'arguments': { 'job-id': 'save0',
+                      'tag': 'state1',
+                      'vmstate': 'disk0',
+                      'devices': ['disk0'] } }"
+
+silent=yes _run_qmp_job $dest 'load0' \
+    "{ 'execute': 'snapshot-load',
+       'arguments': { 'job-id': 'load0',
+                      'tag': 'state1',
+                      'vmstate': 'disk0',
+                      'devices': ['disk0'] } }"
 
 echo
 echo === Shut down and check image ===
 echo
 
-_send_qemu_cmd $src 'quit' ""
-_send_qemu_cmd $dest 'quit' ""
+_send_qemu_cmd $src "{ 'execute': 'quit' }" 'return'
+_send_qemu_cmd $dest "{ 'execute': 'quit' }" 'return'
 wait=1 _cleanup_qemu
 
 _check_test_img
diff --git a/tests/qemu-iotests/201.out b/tests/qemu-iotests/201.out
index 9faf06f996a0..8c75a3441255 100644
--- a/tests/qemu-iotests/201.out
+++ b/tests/qemu-iotests/201.out
@@ -12,12 +12,14 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 
 === On destination, execute savevm and loadvm ===
 
-(qemu) savevm state1
-(qemu) loadvm state1
 
 === Shut down and check image ===
 
-(qemu) quit
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


