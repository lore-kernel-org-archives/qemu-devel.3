Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34B9CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 07:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruSLi-0006Ss-HO; Wed, 10 Apr 2024 03:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKz-0005Zn-1x; Wed, 10 Apr 2024 03:25:43 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ruSKt-0004We-9J; Wed, 10 Apr 2024 03:25:40 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A89BC5D68E;
 Wed, 10 Apr 2024 10:25:04 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 437BDB02CF;
 Wed, 10 Apr 2024 10:23:06 +0300 (MSK)
Received: (nullmailer pid 4191740 invoked by uid 1000);
 Wed, 10 Apr 2024 07:23:04 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 31/87] iotests: Add test for reset/AioContext switches
 with NBD exports
Date: Wed, 10 Apr 2024 10:22:04 +0300
Message-Id: <20240410072303.4191455-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240410085155@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Kevin Wolf <kwolf@redhat.com>

This replicates the scenario in which the bug was reported.
Unfortunately this relies on actually executing a guest (so that the
firmware initialises the virtio-blk device and moves it to its
configured iothread), so this can't make use of the qtest accelerator
like most other test cases. I tried to find a different easy way to
trigger the bug, but couldn't find one.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20240314165825.40261-3-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit e8fce34eccf68a32f4ecf2c6f121ff2ac383d6bf)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/tests/iothreads-nbd-export b/tests/qemu-iotests/tests/iothreads-nbd-export
new file mode 100755
index 0000000000..037260729c
--- /dev/null
+++ b/tests/qemu-iotests/tests/iothreads-nbd-export
@@ -0,0 +1,66 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Copyright (C) 2024 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+# Creator/Owner: Kevin Wolf <kwolf@redhat.com>
+
+import time
+import qemu
+import iotests
+
+iotests.script_initialize(supported_fmts=['qcow2'],
+                          supported_platforms=['linux'])
+
+with iotests.FilePath('disk1.img') as path, \
+     iotests.FilePath('nbd.sock', base_dir=iotests.sock_dir) as nbd_sock, \
+     qemu.machine.QEMUMachine(iotests.qemu_prog) as vm:
+
+    img_size = '10M'
+
+    iotests.log('Preparing disk...')
+    iotests.qemu_img_create('-f', iotests.imgfmt, path, img_size)
+    vm.add_args('-blockdev', f'file,node-name=disk-file,filename={path}')
+    vm.add_args('-blockdev', 'qcow2,node-name=disk,file=disk-file')
+    vm.add_args('-object', 'iothread,id=iothread0')
+    vm.add_args('-device',
+                'virtio-blk,drive=disk,iothread=iothread0,share-rw=on')
+
+    iotests.log('Launching VM...')
+    vm.add_args('-accel', 'kvm', '-accel', 'tcg')
+    #vm.add_args('-accel', 'qtest')
+    vm.launch()
+
+    iotests.log('Exporting to NBD...')
+    iotests.log(vm.qmp('nbd-server-start',
+                       addr={'type': 'unix', 'data': {'path': nbd_sock}}))
+    iotests.log(vm.qmp('block-export-add', type='nbd', id='exp0',
+                       node_name='disk', writable=True))
+
+    iotests.log('Connecting qemu-img...')
+    qemu_io = iotests.QemuIoInteractive('-f', 'raw',
+                                        f'nbd+unix:///disk?socket={nbd_sock}')
+
+    iotests.log('Moving the NBD export to a different iothread...')
+    for i in range(0, 10):
+        iotests.log(vm.qmp('system_reset'))
+        time.sleep(0.1)
+
+    iotests.log('Checking that it is still alive...')
+    iotests.log(vm.qmp('query-status'))
+
+    qemu_io.close()
+    vm.shutdown()
diff --git a/tests/qemu-iotests/tests/iothreads-nbd-export.out b/tests/qemu-iotests/tests/iothreads-nbd-export.out
new file mode 100644
index 0000000000..bc514e35e5
--- /dev/null
+++ b/tests/qemu-iotests/tests/iothreads-nbd-export.out
@@ -0,0 +1,19 @@
+Preparing disk...
+Launching VM...
+Exporting to NBD...
+{"return": {}}
+{"return": {}}
+Connecting qemu-img...
+Moving the NBD export to a different iothread...
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+Checking that it is still alive...
+{"return": {"running": true, "status": "running"}}
-- 
2.39.2


