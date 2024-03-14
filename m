Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE97C54E5D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Mar 2024 16:59:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkoPt-0006Qj-OX; Thu, 14 Mar 2024 12:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rkoPm-0006P5-TL
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1rkoPk-0003Ys-Dd
 for qemu-devel@nongnu.org; Thu, 14 Mar 2024 12:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710435523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/+cEmQc9bjBuc+D/nWptCsUwj1Y/K/92w9pm5FPLf5E=;
 b=eGAjEMNPVtBo5guo/kfnl5LPpTH/stebho82x6rNKozgt3dOE8fZf0fsbuf5Bq+to+890d
 Pudn1JHe440bL5MPSrQze2jFBSKvdGHczTZ4VsdFB8/PxrZpqgbX7xVjo0nEezCEA3Fa1t
 wBMt9exqyLzKYPCCIJTPv4zdOXrtOFc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-ANGe5-KxPWawvnJd6mA_JA-1; Thu, 14 Mar 2024 12:58:42 -0400
X-MC-Unique: ANGe5-KxPWawvnJd6mA_JA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BCE35101A586;
 Thu, 14 Mar 2024 16:58:41 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.105])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 60F8B111E408;
 Thu, 14 Mar 2024 16:58:39 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, aliang@redhat.com, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
Subject: [PATCH for-9.0 2/2] iotests: Add test for reset/AioContext switches
 with NBD exports
Date: Thu, 14 Mar 2024 17:58:25 +0100
Message-ID: <20240314165825.40261-3-kwolf@redhat.com>
In-Reply-To: <20240314165825.40261-1-kwolf@redhat.com>
References: <20240314165825.40261-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This replicates the scenario in which the bug was reported.
Unfortunately this relies on actually executing a guest (so that the
firmware initialises the virtio-blk device and moves it to its
configured iothread), so this can't make use of the qtest accelerator
like most other test cases. I tried to find a different easy way to
trigger the bug, but couldn't find one.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/iothreads-nbd-export | 66 +++++++++++++++++++
 .../tests/iothreads-nbd-export.out            | 19 ++++++
 2 files changed, 85 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/iothreads-nbd-export
 create mode 100644 tests/qemu-iotests/tests/iothreads-nbd-export.out

diff --git a/tests/qemu-iotests/tests/iothreads-nbd-export b/tests/qemu-iotests/tests/iothreads-nbd-export
new file mode 100755
index 0000000000..63cac8fdbf
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
+import asyncio
+import iotests
+import qemu
+import time
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
+    vm.add_args('-blockdev', f'qcow2,node-name=disk,file=disk-file')
+    vm.add_args('-object', 'iothread,id=iothread0')
+    vm.add_args('-device', 'virtio-blk,drive=disk,iothread=iothread0,share-rw=on')
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
2.44.0


