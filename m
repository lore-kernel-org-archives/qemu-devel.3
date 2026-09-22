Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B86C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x972A-0000eu-8n; Tue, 22 Sep 2026 16:24:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x971B-0003m5-0p
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9718-0000M3-TM
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UW23mSHQLZaeviRChpKTXifMRhDBGOq+9e5+n6ZJdrM=;
 b=EpggJz6a9RqrnR9pn3muDq8wXTbrSutYDLiPcWtCWfcn3ktPS9fDvg2Ioq9DTY55UfSDXk
 1UKDJoxYGo8Dix7EVp3V+4v7dAVwtY44+nxALDfnilEs5ir7uJ/g02xcMov2wmMk8MUczq
 P0J/GPCoyfWl2yVdwDfSJ4e0DMP04Z4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-dnsfpMnfOJ-Hsp6Zf0Vkxw-1; Tue,
 22 Sep 2026 16:23:03 -0400
X-MC-Unique: dnsfpMnfOJ-Hsp6Zf0Vkxw-1
X-Mimecast-MFC-AGG-ID: dnsfpMnfOJ-Hsp6Zf0Vkxw_1790108582
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BB3B1800623; Tue, 22 Sep 2026 20:23:02 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C8371956095; Tue, 22 Sep 2026 20:23:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:12 +0400
Subject: [PATCH 65/88] qemu-iotests/156: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-65-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=8014;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=YgO8SeeQJDQXsT41eyxhxVxaJjDtsIQ8/aZsVE2OHLA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKyE43cuPxgmmRysWyHPH0vENMDooi9K/lId
 s8893IER8mJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5YbHD/0ejWAokSfPxplxRnxmCGZX1wy9GFqSpoUzGg+H6mioNN+d6l++pw9yRcbh9Brfi3Phbwn
 tlSqB1CeRRADwIsdSo0nV2OFaDauzYoVDZW3YuOdzL8r7uiEUrYpAB6AvBiNjztlHao4t7q2a9a
 r+VYwiPOTHYMpj0nhyUfNGgkGPNv5r3ZfULloX8SUwKerlUgP/XYqfPUM8f+frMbQkcYg/gYt/H
 2FcZBZnKEzefClpI2Sg6+1TQw7bnSlmd57uYaLDS3bO2nSTPtQ6FjsLpQaBVVLno+POSDFcT/6Q
 qGNiCkiLY+q6/KAueoR1BPuDzQlCcCfIDf2ZV/Bwv/fft4ZtJuWk8t+krk8ukDNOhH/alohwXRp
 ZnElu2ACYdevjTbKzMxWIi2W+BKz8SivJB9B/33iURTwYH3eY1pYBEizBaJM98T0RWBiSKK8eAn
 QtCVKFQL+jClu1NoyM6KJ4oInXBa95lLahpoM1P2h8fUCnUSWPumzFiRbLwx4g4FhhzgLzfsAdw
 HLPrZRnInA7PQGY+vsj8PDkRUBla3GmvffXQvccdTLj88xbtGoYT/DNMYxuaHpoBLBch9Ovouj7
 svE2ny7FDGqaS6XhiOhQ9HR2hnCE9yg7cChmy/P/ECXdC+QYYcoGBD4aeDe+pP1FLu5q/WYfh5m
 SY+HeBZmQAfyaJA==
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/156     | 37 ++++++++++++++--------------
 tests/qemu-iotests/156.out | 60 +++++++++++++++++++---------------------------
 2 files changed, 42 insertions(+), 55 deletions(-)

diff --git a/tests/qemu-iotests/156 b/tests/qemu-iotests/156
index a0e4d1ffd42a..1b0c955c4222 100755
--- a/tests/qemu-iotests/156
+++ b/tests/qemu-iotests/156
@@ -53,7 +53,6 @@ _supported_fmt qcow2 qed
 _supported_proto file
 # Copying files around with cp does not work with external data files
 _unsupported_imgopts data_file
-_require_hmp
 
 # Create source disk
 TEST_IMG="$TEST_IMG.backing" _make_test_img 1M
@@ -80,9 +79,9 @@ _send_qemu_cmd $QEMU_HANDLE \
 
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
@@ -105,9 +104,9 @@ _send_qemu_cmd $QEMU_HANDLE \
 
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
@@ -134,27 +133,27 @@ echo
 
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
index 07e5e83f5d4b..f91ce91d0d60 100644
--- a/tests/qemu-iotests/156.out
+++ b/tests/qemu-iotests/156.out
@@ -14,12 +14,10 @@ Formatting 'TEST_DIR/t.IMGFMT.overlay', fmt=IMGFMT size=1048576 backing_file=TES
                       'format': 'IMGFMT',
                       'mode': 'existing' } }
 {"return": {}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "write -P 3 128k 128k"' } }
-wrote 131072/131072 bytes at offset 131072
-128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'write -P 3 128k 128k' } }
+{"return": {"human-readable-text": "wrote 131072/131072 bytes at offset 131072\n128 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT.target backing_fmt=IMGFMT
 { 'execute': 'drive-mirror',
        'arguments': { 'device': 'source',
@@ -31,12 +29,10 @@ Formatting 'TEST_DIR/t.IMGFMT.target.overlay', fmt=IMGFMT size=1048576 backing_f
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "source", "len": 131072, "offset": 131072, "speed": 0, "type": "mirror"}}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "write -P 4 192k 64k"' } }
-wrote 65536/65536 bytes at offset 196608
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'write -P 4 192k 64k' } }
+{"return": {"human-readable-text": "wrote 65536/65536 bytes at offset 196608\n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 { 'execute': 'block-job-complete',
        'arguments': { 'device': 'source' } }
 {"return": {}}
@@ -46,30 +42,22 @@ wrote 65536/65536 bytes at offset 196608
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "source"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "source"}}
 
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "read -P 1 0k 64k"' } }
-read 65536/65536 bytes at offset 0
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "read -P 2 64k 64k"' } }
-read 65536/65536 bytes at offset 65536
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "read -P 3 128k 64k"' } }
-read 65536/65536 bytes at offset 131072
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
-{ 'execute': 'human-monitor-command',
-       'arguments': { 'command-line':
-                      'qemu-io source "read -P 4 192k 64k"' } }
-read 65536/65536 bytes at offset 196608
-64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 1 0k 64k' } }
+{"return": {"human-readable-text": "read 65536/65536 bytes at offset 0\n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 2 64k 64k' } }
+{"return": {"human-readable-text": "read 65536/65536 bytes at offset 65536\n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 3 128k 64k' } }
+{"return": {"human-readable-text": "read 65536/65536 bytes at offset 131072\n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{ 'execute': 'x-qemu-io',
+       'arguments': { 'device': 'source',
+                      'command': 'read -P 4 192k 64k' } }
+{"return": {"human-readable-text": "read 65536/65536 bytes at offset 196608\n64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 
 { 'execute': 'quit' }
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}

-- 
2.56.0.rc0.29.g47ce80527c56


