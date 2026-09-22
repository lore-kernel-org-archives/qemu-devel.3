Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44F1C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971Q-0005Xu-MM; Tue, 22 Sep 2026 16:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970p-0002v2-Ej
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970n-0000JF-WA
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WL/NB/LYpRz6GPQ1VlpD2yVcfpnkn7O81T6QScjcaI4=;
 b=EYcOFl8rF/7lgKf9PaIQv+u9y+4+VZbxEsYd5PCYY7Qr2huBIGBD2KMNDJ18+neeXkQuQW
 jyflQgapSRtepvWHV9cxqcjCE8B3ashIN7yrngYscvc2lqBdWoCXzZMk7RZVuGTYON7m5q
 RlSQ3vI3YOWMUuFdnLj9nNHKR0l3w5M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-__rVABGVO6WD7nrRt_Dd-g-1; Tue,
 22 Sep 2026 16:22:42 -0400
X-MC-Unique: __rVABGVO6WD7nrRt_Dd-g-1
X-Mimecast-MFC-AGG-ID: __rVABGVO6WD7nrRt_Dd-g_1790108561
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1A6BC1944AA8; Tue, 22 Sep 2026 20:22:41 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36EC61956095; Tue, 22 Sep 2026 20:22:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:06 +0400
Subject: [PATCH 59/88] qemu-iotests/081: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-59-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=124vNbWIhMcpIZzIFSGGEJj9hzlUtGiHMDdivHQxJX0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKyfdNsQLY+n2iy0GM0BJ5bGKwBMJRWk2AYB
 biNOaIVLJGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5Y3CD/9hDibiKvMKLjcTxH8QRP40Sjc48nh6Y+41XdQk//zGvpWD8Jhytmoquf3RpncxKzPifnz
 Kbxca86yt6xKUzMy7tiZRCrAY3lLMNtf8aqcErPXy85XD0fd+epMzT9VK/ufJ0czljL4tOgLy7V
 bONrnmatHDW4QEI0cHWqfy/uj6cjRSe2SAlxwQZtET1jbkoFH9oB5K/fianLfOJe/vqsO/OMOXJ
 GrnvXPpoV4kNUo3bHsnm+b2UJuljeLdgoU+T6PIlnZgVG8XFUBRS3UYohKVGS6+bsxzMlBeyB4y
 lIOVu211Ie+0zKzut7jdSBsufX4JqpN6VWnKsGDgFpR8/4pCCr/Ed5N12Ld9+Vh/9/LBsnwDBbr
 XCF8eieh9msQze0FcjKGhWcsRM+8xJjQGvEtZ61LZxe4z1DdKJOvtVXdrH+W2KAkWNqQOaWZjik
 iJnN0fB0kGt0pSWEGrZKMjLQ2zihIp7UbB3/yqfGPxRD30TrJ1V/Aam//u6Dd4wdPk4f7UfRZXh
 G6M6PqVVJgJhhMP0ybbtS8upwCn9I0QvAQOtoZI2B0YPqgR8uaqkR+RoVP9PfsBZPiGapwFuNqV
 tMPe9VvzQjL9TdqJdJahhBIbdh2Ag0jQXAgv1gdhUz8S5/SgWE9g2Jj/qG3v44mi985GHfePi+Q
 808EPXH/OvwJ43g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/081     | 11 ++++++-----
 tests/qemu-iotests/081.out |  8 ++------
 2 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/081 b/tests/qemu-iotests/081
index d9e729f674c6..f8bf9232bb58 100755
--- a/tests/qemu-iotests/081
+++ b/tests/qemu-iotests/081
@@ -44,7 +44,6 @@ _supported_proto file
 _supported_os Linux
 _require_drivers quorum
 _require_devices virtio-scsi
-_require_hmp
 
 do_run_qemu()
 {
@@ -138,9 +137,10 @@ run_qemu <<EOF
         ]
     }
 }
-{ "execute": "human-monitor-command",
+{ "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io drive0-quorum "read -P 0x32 0 $size"'
+        "device": "drive0-quorum",
+        "command": "read -P 0x32 0 $size"
     }
 }
 { "execute": "quit" }
@@ -200,9 +200,10 @@ run_qemu \
     <<EOF
 { "execute": "qmp_capabilities" }
 {
-    "execute": "human-monitor-command",
+    "execute": "x-qemu-io",
     "arguments": {
-        "command-line": 'qemu-io -d quorum-drive "read -P 0x32 0 $size"'
+        "qdev": "quorum-drive",
+        "command": "read -P 0x32 0 $size"
     }
 }
 { "execute": "quit" }
diff --git a/tests/qemu-iotests/081.out b/tests/qemu-iotests/081.out
index 084b6fbff66a..30a1c67af03c 100644
--- a/tests/qemu-iotests/081.out
+++ b/tests/qemu-iotests/081.out
@@ -32,9 +32,7 @@ QMP_VERSION
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "QUORUM_REPORT_BAD", "data": {"node-name": "drive2", "sectors-count": 20480, "sector-num": 0, "type": "read"}}
-read 10485760/10485760 bytes at offset 0
-10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{"return": {"human-readable-text": "read 10485760/10485760 bytes at offset 0\n10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 
@@ -64,9 +62,7 @@ Testing: -blockdev file,node-name=file1,filename=TEST_DIR/1.IMGFMT -blockdev fil
 QMP_VERSION
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "QUORUM_REPORT_BAD", "data": {"node-name": "file2", "sectors-count": 20480, "sector-num": 0, "type": "read"}}
-read 10485760/10485760 bytes at offset 0
-10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-{"return": ""}
+{"return": {"human-readable-text": "read 10485760/10485760 bytes at offset 0\n10 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)\n"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
 {"return": {}}
 

-- 
2.56.0.rc0.29.g47ce80527c56


