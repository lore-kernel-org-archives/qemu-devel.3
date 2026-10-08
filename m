Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F10CA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 13:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEnwN-00038l-AK; Thu, 08 Oct 2026 09:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvy-0002op-Uu
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:13:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xEnvq-0002S8-56
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 09:13:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791465183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lnrb2VuWv6uqSxWbwAw1mUTpcFrVpfMpcJ4CZVN5eBg=;
 b=FNAg5DHObUrA1F1BkkWYgjKFW8EYwuRYaFxCNdENTgZ+q8BbrjWKQ8GxGLaShbMINGsMBJ
 82vS1cXZz53zIjuWYmmgcn4HncZUlAMmFboI/sFuuVlXJi+GX3pNsKshwyuyJ52AqGrSW5
 K+fMGs7tHwSNZn6jiVEr6xLMHL0W65Y=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-580-x-EbMq6zMvakAZ8xkXHWDg-1; Thu,
 08 Oct 2026 09:12:59 -0400
X-MC-Unique: x-EbMq6zMvakAZ8xkXHWDg-1
X-Mimecast-MFC-AGG-ID: x-EbMq6zMvakAZ8xkXHWDg_1791465178
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 72B071944ABF; Thu,  8 Oct 2026 13:12:58 +0000 (UTC)
Received: from eblake.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A09D230001BB; Thu,  8 Oct 2026 13:12:54 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Guillaume Vincke <guillaume.vincke@ovhcloud.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 08/15] iotests: Add coverage for NBD connect thread start delay
Date: Thu,  8 Oct 2026 08:11:47 -0500
Message-ID: <20261008131216.2437896-25-eblake@redhat.com>
In-Reply-To: <20261008131216.2437896-17-eblake@redhat.com>
References: <20261008131216.2437896-17-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>

Test the connect thread starting condition with reconnect-delay=0 when
the server disconnects after a successful handshake but before running
operations. Prior to the change to nbd_co_establish_connection(), this
test would demonstrate two I/O errors. The tests 264 and 277 covering
reconnection do not use reconnect-delay=0 so this case is not exercised.

Add a test that provokes multiple errors in order to put an NBD client
in the above-mentioned situation and shows that the first operation
starts the connect thread and leads to successful subsequent I/O.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
Message-ID: <20260925155346.357703-3-guillaume.vincke@ovhcloud.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/tests/nbd-stale-connection | 62 +++++++++++++++++++
 .../tests/nbd-stale-connection.out            | 17 +++++
 2 files changed, 79 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
 create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out

diff --git a/tests/qemu-iotests/tests/nbd-stale-connection b/tests/qemu-iotests/tests/nbd-stale-connection
new file mode 100755
index 00000000000..6f6fb6ef1b8
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-stale-connection
@@ -0,0 +1,62 @@
+#!/usr/bin/env python3
+# group: quick
+#
+# Test the NBD client stale channel discard
+#
+# Copyright (C) 2026 OVHcloud
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import time
+import iotests
+from iotests import qemu_nbd_popen, qemu_img_create, file_path, log
+
+
+# estimated duration required by the connect thread to reach a running server
+MAX_NBD_HANDSHAKE_DURATION = 0.5
+# sleep duration of the connection retry in nbd client
+CONNECT_RETRY_DELAY = 1
+
+iotests.script_initialize()
+nbd_sock = file_path('nbd-sock', base_dir=iotests.sock_dir)
+disk = file_path('disk')
+qemu_img_create('-f', iotests.imgfmt, disk, '1M')
+
+with iotests.VM() as vm:
+
+    vm.launch()
+
+    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
+        vm.cmd('blockdev-add', {
+            'driver': 'nbd',
+            'node-name': 'nbd0',
+            'server': {'type': 'unix', 'path': nbd_sock},
+        })
+        iotests.log('=== NBD Device connected ===')
+        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
+
+    iotests.log('=== NBD server down. Detect the break and start the connect '
+                'thread ===')
+    # client was in CONNECTED state a new operation updates to CONNECTING
+    log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
+    # in CONNECTING, the operation starts the connect thread
+    log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
+
+    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
+        iotests.log('=== NBD server up. Wait for the connect thread to park '
+                    'the channel ===')
+        # wait for the connect thread to get a new channel and stop
+        time.sleep(CONNECT_RETRY_DELAY + MAX_NBD_HANDSHAKE_DURATION)
+
+    iotests.log('=== NBD server down. The parked channel is closed ===')
+
+    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
+        iotests.log('=== NBD server up. Restart the connect thread ===')
+        # operation will determine that the channel got closed and restart the
+        # connect thread
+        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
+        # Wait for it to succeed
+        iotests.log('=== Wait for the connect thread to park the new channel. '
+                    'Subsequent operations are successful ===')
+        time.sleep(MAX_NBD_HANDSHAKE_DURATION)
+        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
diff --git a/tests/qemu-iotests/tests/nbd-stale-connection.out b/tests/qemu-iotests/tests/nbd-stale-connection.out
new file mode 100644
index 00000000000..50f80e23058
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-stale-connection.out
@@ -0,0 +1,17 @@
+Start NBD server
+=== NBD Device connected ===
+{"return": {}}
+Kill NBD server
+=== NBD server down. Detect the break and start the connect thread ===
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
+Start NBD server
+=== NBD server up. Wait for the connect thread to park the channel ===
+Kill NBD server
+=== NBD server down. The parked channel is closed ===
+Start NBD server
+=== NBD server up. Restart the connect thread ===
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
+=== Wait for the connect thread to park the new channel. Subsequent operations are successful ===
+{"return": {}}
+Kill NBD server
-- 
2.56.0


