Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAF1D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqa9-0008PT-GL; Mon, 19 Jan 2026 09:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZo-0008D3-UX; Mon, 19 Jan 2026 09:49:58 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZj-0008Nw-I2; Mon, 19 Jan 2026 09:49:55 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id EF2E28086B;
 Mon, 19 Jan 2026 17:49:49 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gnaGbV0CCKo0-Xa41qkHW; Mon, 19 Jan 2026 17:49:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768834189;
 bh=RO/wOYcRCwTBkuY0dTwRudi/MmxKTmNkQmhSEgfxUww=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=yBvWEEg/Lfih+NGPOQm7av1V+wjrGOJrJnNBMIaj1MHgnreOOFHMjlmYNiuaq78S1
 3yBBD8FoH8Ml/UhhVi86urBa7dlE49GDeoJLX46Tgc2VhX6dA7CjxoR+i8pDx/eRDg
 ZLUnWleZ+7JeVGV2N4sviuKANHR8sTMznLBziH3Q=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v10 7/8] iotests: add filter-insertion
Date: Mon, 19 Jan 2026 17:49:40 +0300
Message-ID: <20260119144941.87936-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119144941.87936-1-vsementsov@yandex-team.ru>
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Demonstrate new blockdev-replace API for filter insertion and removal.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/filter-insertion     | 222 ++++++++++++++++++
 tests/qemu-iotests/tests/filter-insertion.out |   5 +
 2 files changed, 227 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/filter-insertion
 create mode 100644 tests/qemu-iotests/tests/filter-insertion.out

diff --git a/tests/qemu-iotests/tests/filter-insertion b/tests/qemu-iotests/tests/filter-insertion
new file mode 100755
index 0000000000..23e114f959
--- /dev/null
+++ b/tests/qemu-iotests/tests/filter-insertion
@@ -0,0 +1,222 @@
+#!/usr/bin/env python3
+#
+# Tests for inserting and removing filters in a block graph.
+#
+# Copyright (c) 2022 Virtuozzo International GmbH.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+import iotests
+from iotests import qemu_img_create, try_remove
+
+
+disk = os.path.join(iotests.test_dir, 'disk')
+sock = os.path.join(iotests.sock_dir, 'sock')
+size = 1024 * 1024
+
+
+class TestFilterInsertion(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img_create('-f', iotests.imgfmt, disk, str(size))
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'disk0',
+            'driver': 'qcow2',
+            'file': {
+                'node-name': 'file0',
+                'driver': 'file',
+                'filename': disk
+            }
+        })
+
+    def tearDown(self):
+        self.vm.shutdown()
+        os.remove(disk)
+        try_remove(sock)
+
+    def test_simple_insertion(self):
+        vm = self.vm
+
+        vm.cmd('blockdev-add', {
+            'node-name': 'filter',
+            'driver': 'blkdebug',
+            'image': 'file0'
+        })
+
+        vm.cmd('blockdev-replace', {
+            'parent': 'disk0',
+            'child': 'file',
+            'new-child': 'filter'
+        })
+
+        # Filter inserted:
+        # disk0 -file-> filter -file-> file0
+        vm.assert_edges_list([
+            ('disk0', 'file', 'filter'),
+            ('filter', 'image', 'file0')
+        ])
+
+        vm.cmd('blockdev-replace', {
+            'parent': 'disk0',
+            'child': 'file',
+            'new-child': 'file0'
+        })
+
+        # Filter replaced, but still exists:
+        # dik0 -file-> file0 <-file- filter
+        vm.assert_edges_list([
+            ('disk0', 'file', 'file0'),
+            ('filter', 'image', 'file0')
+        ])
+
+        vm.cmd('blockdev-del', node_name='filter')
+
+        # Filter removed
+        # dik0 -file-> file0
+        vm.assert_edges_list([
+            ('disk0', 'file', 'file0')
+        ])
+
+    def test_insert_under_qdev(self):
+        vm = self.vm
+
+        vm.cmd('device_add', driver='virtio-scsi')
+        vm.cmd('device_add', id='sda', driver='scsi-hd',
+                     drive='disk0')
+
+        vm.cmd('blockdev-add', {
+            'node-name': 'filter',
+            'driver': 'compress',
+            'file': 'disk0'
+        })
+
+        vm.cmd('blockdev-replace', {
+            'parent': 'sda',
+            'child': 'root',
+            'new-child': 'filter'
+        })
+
+        # Filter inserted:
+        # sda -root-> filter -file-> disk0 -file-> file0
+        vm.assert_edges_list([
+            # parent_node_name, child_name, child_node_name
+            ('sda', 'root', 'filter'),
+            ('filter', 'file', 'disk0'),
+            ('disk0', 'file', 'file0'),
+        ])
+
+        vm.cmd('blockdev-replace', {
+            'parent': 'sda',
+            'child': 'root',
+            'new-child': 'disk0'
+        })
+        vm.cmd('blockdev-del', node_name='filter')
+
+        # Filter removed:
+        # sda -root-> disk0 -file-> file0
+        vm.assert_edges_list([
+            # parent_node_name, child_name, child_node_name
+            ('sda', 'root', 'disk0'),
+            ('disk0', 'file', 'file0'),
+        ])
+
+    def test_insert_under_nbd_export(self):
+        vm = self.vm
+
+        vm.cmd('nbd-server-start',
+                     addr={'type': 'unix', 'data': {'path': sock}})
+        vm.cmd('block-export-add', id='exp1', type='nbd',
+                     node_name='disk0', name='exp1')
+        vm.cmd('block-export-add', id='exp2', type='nbd',
+                     node_name='disk0', name='exp2')
+        vm.cmd('object-add', qom_type='throttle-group',
+                     id='tg', limits={'iops-read': 1})
+
+        vm.cmd('blockdev-add', {
+            'node-name': 'filter',
+            'driver': 'throttle',
+            'throttle-group': 'tg',
+            'file': 'disk0'
+        })
+
+        vm.cmd('blockdev-replace', {
+            'parent': 'exp1',
+            'child': 'root',
+            'new-child': 'filter'
+        })
+
+        # Only exp1 is throttled, exp2 is not:
+        # exp1 -root-> filter
+        #                |
+        #                |file
+        #                v
+        # exp2 -file-> disk0 -file> file0
+        vm.assert_edges_list([
+            # parent_node_name, child_name, child_node_name
+            ('exp1', 'root', 'filter'),
+            ('filter', 'file', 'disk0'),
+            ('disk0', 'file', 'file0'),
+            ('exp2', 'root', 'disk0')
+        ])
+
+        vm.cmd('blockdev-replace', {
+            'parent': 'exp2',
+            'child': 'root',
+            'new-child': 'filter'
+        })
+
+        # Both throttled:
+        # exp1 -root-> filter <-file- exp2
+        #                |
+        #                |file
+        #                v
+        #              disk0 -file> file0
+        vm.assert_edges_list([
+            # parent_node_name, child_name, child_node_name
+            ('exp1', 'root', 'filter'),
+            ('filter', 'file', 'disk0'),
+            ('disk0', 'file', 'file0'),
+            ('exp2', 'root', 'filter')
+        ])
+
+        # Check, that filter is in use and can't be removed
+        result = vm.qmp('blockdev-del', node_name='filter')
+        self.assert_qmp(result, 'error/desc', 'Node filter is in use')
+
+        vm.cmd('blockdev-replace', {
+            'parent': 'exp1',
+            'child': 'root',
+            'new-child': 'disk0'
+        })
+
+        vm.cmd('blockdev-replace', {
+            'parent': 'exp2',
+            'child': 'root',
+            'new-child': 'disk0'
+        })
+        vm.cmd('blockdev-del', node_name='filter')
+
+        # Filter removed:
+        # exp1 -root-> disk0 <-file- exp2
+        #                |
+        #                |file
+        #                v
+        #              file0
+        vm.assert_edges_list([
+            # parent_node_name, child_name, child_node_name
+            ('exp1', 'root', 'disk0'),
+            ('disk0', 'file', 'file0'),
+            ('exp2', 'root', 'disk0')
+        ])
+
+
+if __name__ == '__main__':
+    iotests.main(
+        supported_fmts=['qcow2'],
+        supported_protocols=['file']
+    )
diff --git a/tests/qemu-iotests/tests/filter-insertion.out b/tests/qemu-iotests/tests/filter-insertion.out
new file mode 100644
index 0000000000..8d7e996700
--- /dev/null
+++ b/tests/qemu-iotests/tests/filter-insertion.out
@@ -0,0 +1,5 @@
+...
+----------------------------------------------------------------------
+Ran 3 tests
+
+OK
-- 
2.52.0


