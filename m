Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F4A4CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdDF-00018E-MQ; Mon, 08 Jun 2026 12:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdDE-00017v-9e
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wWdDC-0007SS-Ez
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780937549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIeebk1q6gdGRjMOS5TNro+4Fks1Jr7HbLNnxXTKGig=;
 b=VUdB+dSI4RrezqWVY81BSh25flxLdsAfdMsmblFwComaIGx9FGNk8OhZyTGleRhQm6GcEH
 PPblFtlggPkFBeA3A6qblRdSlJWUteTIx4iYECmFlHLlb6GjTfrDmQdZZl4imD4yidxQDA
 hH9X3YmSM+L+rRcuHTwO5A3kJtH7BRM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-19-ZyueqmrUPWyPPJqQNTc2ag-1; Mon,
 08 Jun 2026 12:52:26 -0400
X-MC-Unique: ZyueqmrUPWyPPJqQNTc2ag-1
X-Mimecast-MFC-AGG-ID: ZyueqmrUPWyPPJqQNTc2ag_1780937545
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 508471954237; Mon,  8 Jun 2026 16:52:25 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.50.32])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E919D19540CB; Mon,  8 Jun 2026 16:52:23 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 7/8] iotests: test shared mmap for fuse export
Date: Mon,  8 Jun 2026 18:52:06 +0200
Message-ID: <20260608165207.307488-8-kwolf@redhat.com>
In-Reply-To: <20260608165207.307488-1-kwolf@redhat.com>
References: <20260608165207.307488-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Fiona Ebner <f.ebner@proxmox.com>

This test would have worked before commit 8599559580 ("fuse: Set
direct_io and parallel_direct_writes") and is working again since
commit HEAD~1 ("block/export/fuse: set FUSE_DIRECT_IO_ALLOW_MMAP flag
to fix regression").

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260506145424.10249-4-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/tests/fuse-mmap-shared     | 103 ++++++++++++++++++
 tests/qemu-iotests/tests/fuse-mmap-shared.out |   5 +
 2 files changed, 108 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/fuse-mmap-shared
 create mode 100644 tests/qemu-iotests/tests/fuse-mmap-shared.out

diff --git a/tests/qemu-iotests/tests/fuse-mmap-shared b/tests/qemu-iotests/tests/fuse-mmap-shared
new file mode 100755
index 00000000000..a0a10cea6ac
--- /dev/null
+++ b/tests/qemu-iotests/tests/fuse-mmap-shared
@@ -0,0 +1,103 @@
+#!/usr/bin/env python3
+# group: rw
+#
+# Test that a FUSE export can be mmap()-ed with MAP_SHARED
+#
+# Copyright (C) 2026 Proxmox Server Solutions GmbH
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import itertools
+import mmap
+from mmap import MAP_SHARED
+from pathlib import Path
+
+import iotests
+from iotests import qemu_img, qemu_io, QemuStorageDaemon
+
+def test_fuse_support(mount_point):
+    test_qsd = QemuStorageDaemon('--blockdev', 'null-co,node-name=node0',
+                                 qmp=True)
+    res = test_qsd.qmp('block-export-add', {
+        'id': 'exp0',
+        'type': 'fuse',
+        'node-name': 'node0',
+        'mountpoint': mount_point,
+        'allow-other': 'off'
+    })
+    test_qsd.stop()
+    if 'error' in res:
+        assert (res['error']['desc'] ==
+                "Parameter 'type' does not accept value 'fuse'")
+        iotests.notrun('No FUSE support')
+
+# Shared mmap when using direct IO is only supported for Linux kernels >= 6.6
+# with commit e78662e818f94 ("fuse: add a new fuse init flag to relax
+# estrictions in no cache mode").
+def test_linux_kernel_support():
+    [major, minor] = map(int, os.uname().release.split('.')[:2])
+    if major < 6 or (major == 6 and minor < 6):
+        iotests.notrun('No kernel support for shared mmap with direct IO')
+
+image_size = 1 * 1024 * 1024
+image = os.path.join(iotests.test_dir, 'image.' + iotests.imgfmt)
+fuse_mount_point = os.path.join(iotests.test_dir, 'export.fuse')
+Path(fuse_mount_point).touch()
+
+test_fuse_support(fuse_mount_point)
+test_linux_kernel_support()
+
+class TestMmapShared(iotests.QMPTestCase):
+
+    def setUp(self):
+        qemu_img('create', '-f', iotests.imgfmt, image, str(image_size))
+        qemu_io(image, '-c', f'write -P 23 0 {image_size}')
+
+        self.qsd = QemuStorageDaemon(qmp=True)
+
+        self.qsd.cmd('blockdev-add', {
+            'node-name': 'node0',
+            'driver': iotests.imgfmt,
+            'file': {
+                'driver': 'file',
+                'filename': image
+            }
+        })
+
+        self.qsd.cmd('block-export-add', {
+            'id': 'exp0',
+            'type': 'fuse',
+            'node-name': 'node0',
+            'mountpoint': fuse_mount_point,
+            'writable': True,
+            'allow-other': 'off'
+        })
+
+    def tearDown(self):
+        self.stop_qsd()
+        os.remove(image)
+        os.remove(fuse_mount_point)
+
+    def stop_qsd(self):
+        if self.qsd:
+            self.qsd.stop()
+            self.qsd = None
+
+    def test_mmap_shared(self):
+        with open(fuse_mount_point, 'r+b') as file:
+            with mmap.mmap(file.fileno(), image_size, flags=MAP_SHARED) as mm:
+                buf = bytearray(image_size)
+                buf[:] = itertools.repeat(23, image_size)
+                assert mm.read(image_size) == buf
+                buf[:] = itertools.repeat(42, image_size)
+                mm.seek(0)
+                mm.write(buf)
+                mm.flush()
+        self.stop_qsd()
+        qemu_io(image, '-c', f'read -P 42 0 {image_size}')
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['generic'],
+                 supported_protocols=['file'],
+                 supported_platforms=['linux'])
diff --git a/tests/qemu-iotests/tests/fuse-mmap-shared.out b/tests/qemu-iotests/tests/fuse-mmap-shared.out
new file mode 100644
index 00000000000..ae1213e6f86
--- /dev/null
+++ b/tests/qemu-iotests/tests/fuse-mmap-shared.out
@@ -0,0 +1,5 @@
+.
+----------------------------------------------------------------------
+Ran 1 tests
+
+OK
-- 
2.54.0


