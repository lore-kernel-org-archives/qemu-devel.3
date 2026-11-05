Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C16606A92F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ovhcloud.com header.i=@ovhcloud.com header.a=rsa-sha256 header.s=mailout header.b=TnIgQ+Wn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP0Xc-0007x4-4e; Thu, 05 Nov 2026 11:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xP0XU-0007vy-Gu
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:42:14 -0500
Received: from 1.mo508.mail-out.ovh.net ([5.135.90.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <guillaume.vincke@ovhcloud.com>)
 id 1xP0XQ-00029p-Ea
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 11:42:10 -0500
Received: from DAGFR11EX3.OVH.local (unknown [10.110.0.161])
 by mo508.mail-out.ovh.net (Postfix) with ESMTPS id 4jL7Pf58FYz7tDf;
 Thu,  5 Nov 2026 16:41:58 +0000 (UTC)
Received: from ovhcloud.com (109.190.254.61) by DAGFR11EX3.OVH.local
 (172.16.2.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 17:41:58 +0100
From: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-block@nongnu.org>, Eric Blake <eblake@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Kevin Wolf
 <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Guillaume Vincke
 <guillaume.vincke@ovhcloud.com>
Subject: [PATCH v3 2/2] iotests: Add coverage for NBD connect thread start
 delay
Date: Thu, 5 Nov 2026 17:41:24 +0100
Message-ID: <20261105164124.249395-3-guillaume.vincke@ovhcloud.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105164124.249395-1-guillaume.vincke@ovhcloud.com>
References: <20261105164124.249395-1-guillaume.vincke@ovhcloud.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS4.OVH.local (172.16.1.4) To DAGFR11EX3.OVH.local
 (172.16.2.113)
X-OVH-CORPLIMIT-SKIP: true
x-ovh-tracer-id: 12814429793129546023
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTEn9tFPusAA5Q4MqpjZoNzci9VQHLzLko0uQkRTM2DlaAFbwRwjsWYA3SgYuzW9N0fjh4Sfl6p/cqpgLJGf5atzEkfGH8mA7lwLEQeTYGX8Mzyt6Vth5v7GzqtsPvNY8hJmw7I1UHjbL9Wxati8Vbf3SShIjOIPnoKX50VnJJSJcPI7onvv6Oy1NjSye3oA9/gWuiSedOpPcYYW9IXyEmO7L6cHdETzxgAKwThIwZx+JRN1edq71TOWsfeNkaVsxkyjN/1CrJ1M+Pnidq9dUoYmc62gSu9siwv/eRHmy9W1CHJVcVoysXgZ38MyYSpuHxjzw0Xj50ErHGzKgN1XGuYMHjoFGRbN2o2+AejSj/sfgt6H5kAN7KMT/HtEWuLComVMR3YxVqcs/jA4+Otfy/FFZKZ/Cq81WpLzyUSclsgKlLmjhnT/seZB5QWEXTIjId9cfB1CwynuivOEx3Dv9n/3ULqbgrhBLkV9bxVW7jjhUPiaQe5keh/IvuiLU4lfSCtJTqKXeVIDpC7pvf8c+tkaczfiUyzl2w1x8tQnPL+c0ykWiLqHwV6AyjqnvHWQnRc7OEzyODdQ23uT2hmMM7Pxw6JrWt0yPjNesHuebh/E4d9NLcJSAkl7ts8sHMQVy2gpRrqFqDTi7XlH9i1Sku+tanzIMNqWaQoZDmJYZee41w
DKIM-Signature: a=rsa-sha256; bh=kS4jIRriSQDC9LhEc27uEKkT6kKs3DmfEVsBCVntYYA=; 
 c=relaxed/relaxed; d=ovhcloud.com; h=From; s=mailout;
 t=1793896918; v=1; 
 b=TnIgQ+WnMgb9d4BArvW6HIDIRm2ewZ9Xjkj/+w+IdD64R/pJ3IfgqjQIzoRZVxsVkSAQKMlO
 bg70NCCvOM9z9wSx0uinV9RPTTi0+DvFkBDvnVGlju+hEdtU8AyG5lIg/KY+NT5Jl39ePcm6zO3
 cqbNmDYIRktXEUffjqVvccIE=
Received-SPF: pass client-ip=5.135.90.176;
 envelope-from=guillaume.vincke@ovhcloud.com; helo=1.mo508.mail-out.ovh.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: guillaume.vincke@ovhcloud.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Test the connect thread starting condition with reconnect-delay=0 when
the server disconnects after a successful handshake but before running
operations. Prior to the change to nbd_co_establish_connection(), this
test would demonstrate two I/O errors. The tests 264 and 277 covering
reconnection do not use reconnect-delay=0 so this case is not exercised.

Add a test that provokes multiple errors in order to put an NBD client
in the above-mentioned situation and shows that the first operation
starts the connect thread and leads to successful subsequent I/O.

Signed-off-by: Guillaume Vincke <guillaume.vincke@ovhcloud.com>
---
 tests/qemu-iotests/tests/nbd-stale-connection | 60 +++++++++++++++++++
 .../tests/nbd-stale-connection.out            | 17 ++++++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
 create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out

diff --git a/tests/qemu-iotests/tests/nbd-stale-connection b/tests/qemu-iotests/tests/nbd-stale-connection
new file mode 100755
index 0000000000..e361bccfa9
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-stale-connection
@@ -0,0 +1,60 @@
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
+MAX_NBD_CONNECT_DURATION = 1
+
+iotests.script_initialize(supported_fmts=['qcow2'])
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
+
+    with qemu_nbd_popen('-k', nbd_sock, '-f', iotests.imgfmt, disk):
+        iotests.log('=== NBD server up. Wait for the connect thread to park '
+                    'the channel ===')
+        # in CONNECTING, the operation starts the connect thread
+        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
+        # wait for the connect thread to get a new channel and stop
+        time.sleep(MAX_NBD_CONNECT_DURATION)
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
+        time.sleep(MAX_NBD_CONNECT_DURATION)
+        log(vm.qmp('x-qemu-io', device='nbd0', command='write -P 0x5a 0 64k'))
diff --git a/tests/qemu-iotests/tests/nbd-stale-connection.out b/tests/qemu-iotests/tests/nbd-stale-connection.out
new file mode 100644
index 0000000000..065ba329e9
--- /dev/null
+++ b/tests/qemu-iotests/tests/nbd-stale-connection.out
@@ -0,0 +1,17 @@
+Start NBD server
+=== NBD Device connected ===
+{"return": {}}
+Kill NBD server
+=== NBD server down. Detect the break and start the connect thread ===
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
+Start NBD server
+=== NBD server up. Wait for the connect thread to park the channel ===
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
+Kill NBD server
+=== NBD server down. The parked channel is closed ===
+Start NBD server
+=== NBD server up. Restart the connect thread ===
+{"error": {"class": "GenericError", "desc": "write failed: Input/output error"}}
+=== Wait for the connect thread to park the new channel. Subsequent operations are successful ===
+{"return": {}}
+Kill NBD server
-- 
2.43.0


