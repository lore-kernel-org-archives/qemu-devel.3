Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7282C30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:55:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMREH-0006Mq-42; Wed, 26 Jun 2024 07:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMREE-0006Lz-5a; Wed, 26 Jun 2024 07:54:22 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMRE7-0007IL-4r; Wed, 26 Jun 2024 07:54:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 6CD0660E2C;
 Wed, 26 Jun 2024 14:54:13 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id prOe6Z0rMmI0-d469pGrj; Wed, 26 Jun 2024 14:54:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719402852;
 bh=fSQRoBzjhgoDrc00kC26HOrCVdxQAb1MOa8uUFy8syc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=xQIOOjwsjyIdzeueTFPccoIBGikRydQfacuztRhjzu4dnQobWK/d1VKwtYY9s2lo6
 XRneVYrrBro+3qDPEDMFQJLsLD2gQylFmErfIW8b2Se6RcT5h3tAVgj5XNOLl1VKJm
 XBfge6sG7EFc9SDfdCl1rsv+2Fhi2bZ5IVBORD54=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v9 7/7] iotests: add filter-insertion
Date: Wed, 26 Jun 2024 14:53:50 +0300
Message-Id: <20240626115350.405778-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626115350.405778-1-vsementsov@yandex-team.ru>
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Demonstrate new blockdev-replace API for filter insertion and removal.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/tests/filter-insertion     | 236 ++++++++++++++++++
 tests/qemu-iotests/tests/filter-insertion.out |   5 +
 2 files changed, 241 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/filter-insertion
 create mode 100644 tests/qemu-iotests/tests/filter-insertion.out

diff --git a/tests/qemu-iotests/tests/filter-insertion b/tests/qemu-iotests/tests/filter-insertion
new file mode 100755
index 0000000000..02a0978f96
--- /dev/null
+++ b/tests/qemu-iotests/tests/filter-insertion
@@ -0,0 +1,236 @@
+#!/usr/bin/env python3
+#
+# Tests for inserting and removing filters in a block graph.
+#
+# Copyright (c) 2022 Virtuozzo International GmbH.
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
+            'parent-type': 'driver',
+            'node-name': 'disk0',
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
+            'parent-type': 'driver',
+            'node-name': 'disk0',
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
+            'parent-type': 'qdev',
+            'qdev-id': 'sda',
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
+            'parent-type': 'qdev',
+            'qdev-id': 'sda',
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
+            'parent-type': 'export',
+            'export-id': 'exp1',
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
+            'parent-type': 'export',
+            'export-id': 'exp2',
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
+            'parent-type': 'export',
+            'export-id': 'exp1',
+            'new-child': 'disk0'
+        })
+
+        vm.cmd('blockdev-replace', {
+            'parent-type': 'export',
+            'export-id': 'exp2',
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
2.34.1


