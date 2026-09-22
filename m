Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E93C982FA
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:26:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971P-0005U7-Fa; Tue, 22 Sep 2026 16:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9718-0003Ui-Jm
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x9716-0000LB-0V
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHge1UqbSGm97cnWevOEtitWDpLtmhAvKSahzYvBaF4=;
 b=c4+zfX9VWFdi+SVF+Lf86EkzKAAR18hHUV5ABCw8YWx5MmCUvDd4u0klV64x2gOufWNAfs
 Mp0B3AB2s2e3ejMr2WH2hb9fHC2GtVcYESlJk811zmnnEaenzp2M0AeQB5CS2kIbU9PuPX
 aXLN0AWBSS0BDOpe/CTbguMnxILMGhI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-hBx786ruMBCRr9WbEOX7VQ-1; Tue,
 22 Sep 2026 16:22:59 -0400
X-MC-Unique: hBx786ruMBCRr9WbEOX7VQ-1
X-Mimecast-MFC-AGG-ID: hBx786ruMBCRr9WbEOX7VQ_1790108575
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E4BB195DE12; Tue, 22 Sep 2026 20:22:55 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5E8383000223; Tue, 22 Sep 2026 20:22:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:10 +0400
Subject: [PATCH 63/88] qemu-iotests/161: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-63-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=5927;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=rZDeep1FOHy6Ed8MZUb9yqpB7CF7Ks5+iOx3Mw3PFZs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKy5FocikhtzLWxuAgIbYozpbueUMRdweETT
 7+y05LwgACJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5ZudD/0aCNLX/IxlEWnd7+jeXXu1he7EIDEvQwCmu3CfhWH9O0zmd8vicnzZoaS9ZU+8wlFxaTZ
 XhmN2CcMf1xOnxjr950bzaUosWCrvI6a6W+NxZ8llQ7Xu+LdydDShOC1GOOBmgQFQA4kVpgrsoX
 bZndVOz4q04ilAeW/Wkel3FmdC42/zaAVpJXV71XXABGsp7WzMqlORnfbpGb35uNfNviuxUNwec
 LqBxbod6CQges/pPab+bN6FCoUpe19pnOQ0q5IcGUDpMS4ReW08Zi3kk/RUgJ7sd9TTDV7K7wlL
 0wPJd+QUa6UHWXGuRunFQH+z0wvctkjGz5MUZsnw4R48B0Gx6JFWMV4o4WuVcqoNjRI4h3nq8hg
 pE2dctgB63DhQQldmb/aWtcCUC5P5vcCznc5qnLDkQfSj5lNCnl/ZubMPm6z9kTx8Xc5jtn615e
 xSVKN5W+63tvw2nOEkGhK/c8rOmTbP+HiUkmJDlKYS9OPGA1Zl9JykKetmFI0qAyYOLScZZVnMu
 0xR6UkCVCnw5wqX1SbLP3akbFgxBcB9PWT+LgVVEd6Nql2MjAYz2bljpwlYhE0824/4QGhbOEUi
 T21drLSIXg+a01w2nRw10wQkuYyeuwWWrD6HoQZSO76M/8YkaQvRGsBK4yKsEiIqvBOP4N6VYu/
 +6/Tvig79MoIwYQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
 tests/qemu-iotests/161     | 19 +++++++++----------
 tests/qemu-iotests/161.out | 24 ++++++++++++------------
 2 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/tests/qemu-iotests/161 b/tests/qemu-iotests/161
index 8ca139262975..0f4d59b97d24 100755
--- a/tests/qemu-iotests/161
+++ b/tests/qemu-iotests/161
@@ -45,7 +45,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto file fuse
 _supported_os Linux
-_require_hmp
 
 IMG_SIZE=1M
 
@@ -65,9 +64,9 @@ _send_qemu_cmd $QEMU_HANDLE \
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
@@ -93,9 +92,9 @@ _send_qemu_cmd $QEMU_HANDLE \
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
@@ -126,9 +125,9 @@ _send_qemu_cmd $QEMU_HANDLE \
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
index 6cc285afcfdc..ebadca1c79a2 100644
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
+{"return": {"human-readable-text": ""}}
 
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
+{"return": {"human-readable-text": ""}}
 
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
+{"return": {"human-readable-text": ""}}
 *** done

-- 
2.56.0.rc0.29.g47ce80527c56


