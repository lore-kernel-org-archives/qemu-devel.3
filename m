Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A9DC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x970N-0001XG-OI; Tue, 22 Sep 2026 16:22:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zd-00006X-PL
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x96zb-00008A-V7
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RH0wxBTe94pOM5GfZrIQM3kcsli8tprvI/EcvABYvlo=;
 b=i1mfL3A9rpj+Lzy5FPItj5sZEkXkw777lgRNKQjm8gdZcjDvC2b6hb3Aklwc6iw1qLMacb
 ipKyBJYfotWBiKAewgcLG9FQs/xxtpNtoRvEa8pR97lD04KbFuqWdO5JwUARydfjNg7HPM
 /mOTyIx6lJH/qIrPESmO8utBvHMWl+A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-204-h0XYdurHOd-gzOnDoAjRmQ-1; Tue,
 22 Sep 2026 16:21:30 -0400
X-MC-Unique: h0XYdurHOd-gzOnDoAjRmQ-1
X-Mimecast-MFC-AGG-ID: h0XYdurHOd-gzOnDoAjRmQ_1790108489
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E37F19772DE; Tue, 22 Sep 2026 20:21:29 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 119081800370; Tue, 22 Sep 2026 20:21:27 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:17:46 +0400
Subject: [PATCH 39/88] qemu-iotests/qsd-migrate: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-39-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=7933;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xenZorm4NUjxrHwnhJUq3la4DbYRVWCbOjBEiUifD7A=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGqy4rChEr5DicDIU85zbbEiipMHxmHIc4ftefazwkZt/4Iwv
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJqsuKwAAoJENro4Ql1lpzlS5oQAKlx
 j2elU3MVkaEntPWgjMaURh2h/663t4nQSrJOVrj7l7vDYJTUnS1fDhTd+A8I2wyvI2+53WW1cmm
 /AmQzdrgDY8efe91WFKWl53/GUtQy54Vvuc6wj7ZXTvf7zIo7ggB1ieiSQsmb2qkRXziImFtQeT
 QBp84aZY0m1zEXVNvke+TYxeyT0YJqjgy/R2CJv0yTocOc697KB8ySSfu2uJxwomuUfx5czgBg2
 uZNu7S3t9EBBY6QHUsFbJbEIVvirZXDZm84EAZAkdpTiJGadgADTFXHSSrEp7uV8O9YhUEuE8pD
 x5mjaNxQjigNjEnTwT15XL8jbSqNVpYImPt5IMGLTJyuumDLg7Q2hrrIWxwQ5NOMnennZBfptUE
 yyQfCw2CkcCTPksAb/CnIznxzKZ54pxctzxmcwTeXgQ3L1MIz1rRL9LIwpa8C23EPcj+YxY03Vl
 hmuFIvFkECzHoDjYY7M+8UlHZBGDo0zFnx4ESWULVh+Ooa71sHZjTYRNGoBldk8GOzruQfXbtGL
 a+MDe7FUAMCiZF8SWDsRqYyyQWYQG3bkfl4MIclZhYOdOg8kccWPLNpXtTooHA4CSpObGcPi/5F
 10JRlv11G/LNSGhBWijilyAmWY/Est2tmis1nw7DVs5PqwxZ1UkTjmTi4MdTsxgH66QqVb1kS9A
 EtwGg
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

Keep the vm_src/vm_dst log, even if they should be empty now.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/tests/qsd-migrate     | 23 ++++++++---------
 tests/qemu-iotests/tests/qsd-migrate.out | 44 ++++++++++++--------------------
 2 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/tests/qemu-iotests/tests/qsd-migrate b/tests/qemu-iotests/tests/qsd-migrate
index d76278b576c2..e0b0a8f1c914 100755
--- a/tests/qemu-iotests/tests/qsd-migrate
+++ b/tests/qemu-iotests/tests/qsd-migrate
@@ -20,12 +20,11 @@
 
 import iotests
 
-from iotests import filter_qemu_io, filter_qtest
+from iotests import filter_qtest
 
 iotests.script_initialize(supported_fmts=['qcow2', 'qed', 'raw'],
                           supported_protocols=['file'],
-                          supported_platforms=['linux'],
-                          require_hmp=True)
+                          supported_platforms=['linux'])
 
 with iotests.FilePath('disk.img') as path, \
      iotests.FilePath('nbd-src.sock', base_dir=iotests.sock_dir) as nbd_src, \
@@ -75,9 +74,9 @@ with iotests.FilePath('disk.img') as path, \
     vm_dst.launch()
 
     iotests.log('\nTest I/O on the source')
-    vm_src.hmp_qemu_io('virtio0/virtio-backend', 'write -P 0x11 0 4k',
+    vm_src.qmp_qemu_io('virtio0/virtio-backend', 'write -P 0x11 0 4k',
                        use_log=True, qdev=True)
-    vm_src.hmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
+    vm_src.qmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
                        use_log=True, qdev=True)
 
     iotests.log('\nStarting migration...')
@@ -100,9 +99,9 @@ with iotests.FilePath('disk.img') as path, \
 
     # Reading is okay from both sides while the image is inactive. Note that
     # the destination may have stale data until it activates the image, though.
-    vm_src.hmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
+    vm_src.qmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
                        use_log=True, qdev=True)
-    vm_dst.hmp_qemu_io('virtio0/virtio-backend', 'read 0 4k',
+    vm_dst.qmp_qemu_io('virtio0/virtio-backend', 'read 0 4k',
                        use_log=True, qdev=True)
 
     iotests.log(qsd_dst.qmp('blockdev-set-active', {'active': True}))
@@ -115,13 +114,13 @@ with iotests.FilePath('disk.img') as path, \
     iotests.log('\nTest I/O on the destination')
 
     # Now the destination must see what the source wrote
-    vm_dst.hmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
+    vm_dst.qmp_qemu_io('virtio0/virtio-backend', 'read -P 0x11 0 4k',
                        use_log=True, qdev=True)
 
     # And be able to overwrite it
-    vm_dst.hmp_qemu_io('virtio0/virtio-backend', 'write -P 0x22 0 4k',
+    vm_dst.qmp_qemu_io('virtio0/virtio-backend', 'write -P 0x22 0 4k',
                        use_log=True, qdev=True)
-    vm_dst.hmp_qemu_io('virtio0/virtio-backend', 'read -P 0x22 0 4k',
+    vm_dst.qmp_qemu_io('virtio0/virtio-backend', 'read -P 0x22 0 4k',
                        use_log=True, qdev=True)
 
     iotests.log('\nDone')
@@ -130,12 +129,12 @@ with iotests.FilePath('disk.img') as path, \
     iotests.log('\n--- vm_src log ---')
     log = vm_src.get_log()
     if log:
-        iotests.log(log, [filter_qtest, filter_qemu_io])
+        iotests.log(log, [filter_qtest])
     qsd_src.stop()
 
     vm_dst.shutdown()
     iotests.log('\n--- vm_dst log ---')
     log = vm_dst.get_log()
     if log:
-        iotests.log(log, [filter_qtest, filter_qemu_io])
+        iotests.log(log, [filter_qtest])
     qsd_dst.stop()
diff --git a/tests/qemu-iotests/tests/qsd-migrate.out b/tests/qemu-iotests/tests/qsd-migrate.out
index 4a5241e5d40f..e606e857ce9c 100644
--- a/tests/qemu-iotests/tests/qsd-migrate.out
+++ b/tests/qemu-iotests/tests/qsd-migrate.out
@@ -5,10 +5,10 @@ Launching destination QSD...
 Launching destination VM...
 
 Test I/O on the source
-{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"write -P 0x11 0 4k\""}}
-{"return": ""}
-{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"read -P 0x11 0 4k\""}}
-{"return": ""}
+{"execute": "x-qemu-io", "arguments": {"command": "write -P 0x11 0 4k", "qdev": "virtio0/virtio-backend"}}
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"execute": "x-qemu-io", "arguments": {"command": "read -P 0x11 0 4k", "qdev": "virtio0/virtio-backend"}}
+{"return": {"human-readable-text": "read 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 
 Starting migration...
 {"execute": "migrate-set-capabilities", "arguments": {"capabilities": [{"capability": "events", "state": true}, {"capability": "pause-before-switchover", "state": true}]}}
@@ -20,10 +20,10 @@ Starting migration...
 
 Pre-switchover: Reconfigure QSD instances
 {"return": {}}
-{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"read -P 0x11 0 4k\""}}
-{"return": ""}
-{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"read 0 4k\""}}
-{"return": ""}
+{"execute": "x-qemu-io", "arguments": {"command": "read -P 0x11 0 4k", "qdev": "virtio0/virtio-backend"}}
+{"return": {"human-readable-text": "read 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"execute": "x-qemu-io", "arguments": {"command": "read 0 4k", "qdev": "virtio0/virtio-backend"}}
+{"return": {"human-readable-text": "read 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 {"return": {}}
 
 Completing migration...
@@ -31,29 +31,17 @@ Completing migration...
 {"return": {}}
 
 Test I/O on the destination
-{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"read -P 0x11 0 4k\""}}
-{"return": ""}
-{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"write -P 0x22 0 4k\""}}
-{"return": ""}
-{"execute": "human-monitor-command", "arguments": {"command-line": "qemu-io -d virtio0/virtio-backend \"read -P 0x22 0 4k\""}}
-{"return": ""}
+{"execute": "x-qemu-io", "arguments": {"command": "read -P 0x11 0 4k", "qdev": "virtio0/virtio-backend"}}
+{"return": {"human-readable-text": "read 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"execute": "x-qemu-io", "arguments": {"command": "write -P 0x22 0 4k", "qdev": "virtio0/virtio-backend"}}
+{"return": {"human-readable-text": "wrote 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
+{"execute": "x-qemu-io", "arguments": {"command": "read -P 0x22 0 4k", "qdev": "virtio0/virtio-backend"}}
+{"return": {"human-readable-text": "read 4096/4096 bytes at offset 0\n4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 
 Done
 
 --- vm_src log ---
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
 
 --- vm_dst log ---
-read 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-wrote 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 4096/4096 bytes at offset 0
-4 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+

-- 
2.56.0.rc0.29.g47ce80527c56


