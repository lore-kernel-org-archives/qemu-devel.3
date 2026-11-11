Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FB8606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 03:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ni47f4oY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQzNe-0007yv-GH; Tue, 10 Nov 2026 22:52:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNd-0007yC-DB
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xQzNb-0006h8-J6
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 22:52:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794369130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SDB5ZSWebPg3KznoweaVluLCjG/Fe/G5yGe36con4AM=;
 b=Ni47f4oYCl7qXM+qyMav2nHnd/XcdxfmyhAEV9VDk4SUC7r8DfGlKi8yDFKaLCyaQ3PcLm
 QNx7GeaRBQoz8CcMDII9+9cZoXJhWGihVS9sYaR/TOA4CSH29rP7idJXRgEsM8jsAHluDl
 Az5mBbsPtMntAqgDEu+JThyOUFQ2d9c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-UWXz1LjNOyGSpNAU3EUXxg-1; Tue,
 10 Nov 2026 22:52:08 -0500
X-MC-Unique: UWXz1LjNOyGSpNAU3EUXxg-1
X-Mimecast-MFC-AGG-ID: UWXz1LjNOyGSpNAU3EUXxg_1794369127
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 191721800599; Wed, 11 Nov 2026 03:52:07 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 839AD3001DA0; Wed, 11 Nov 2026 03:52:05 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Guillaume Vincke <guillaume.vincke@ovhcloud.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PULL 2/8] iotests: Add coverage for NBD connect thread start delay
Date: Tue, 10 Nov 2026 21:51:27 -0600
Message-ID: <20261111035200.1751734-12-eblake@redhat.com>
In-Reply-To: <20261111035200.1751734-10-eblake@redhat.com>
References: <20261111035200.1751734-10-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
Message-ID: <20261105164124.249395-3-guillaume.vincke@ovhcloud.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/tests/nbd-stale-connection | 60 +++++++++++++++++++
 .../tests/nbd-stale-connection.out            | 17 ++++++
 2 files changed, 77 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/nbd-stale-connection
 create mode 100644 tests/qemu-iotests/tests/nbd-stale-connection.out

diff --git a/tests/qemu-iotests/tests/nbd-stale-connection b/tests/qemu-iotests/tests/nbd-stale-connection
new file mode 100755
index 00000000000..e361bccfa98
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
index 00000000000..065ba329e96
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
2.56.0


