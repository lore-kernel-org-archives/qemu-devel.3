Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A54C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 11:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1PYb-0008Hl-N0; Mon, 29 Apr 2024 07:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYY-0008Fo-BU; Mon, 29 Apr 2024 07:52:26 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1PYS-0001or-2l; Mon, 29 Apr 2024 07:52:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2a2a:0:640:d546:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 8F895609DD;
 Mon, 29 Apr 2024 14:52:16 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0qOEuD11MuQ0-KVeuepHA; Mon, 29 Apr 2024 14:52:15 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714391535;
 bh=7D8uvI1If1J99UfFmUrbXLUBowb77iehvHL1xWcyJAs=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=VJRyLPd2Mu++EkxY2bM8A+BkqTmeZsllp3qG15OQqffZ/5A2v/4fEROuL+NfCxIJD
 2agwGpLZnr6cZWW4fvWupXWpgsFBCQa/p6cZUfSEWiSz4+hfFz5SFESBjbM59779Wy
 8KQTQpJ1Vn8b/pL+HKGPyopGrCr0PemuP8J/fzXM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, vsementsov@yandex-team.ru,
 Fiona Ebner <f.ebner@proxmox.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PULL 6/6] iotests: add backup-discard-source
Date: Mon, 29 Apr 2024 14:51:57 +0300
Message-Id: <20240429115157.2260885-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
References: <20240429115157.2260885-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

Add test for a new backup option: discard-source.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
Message-Id: <20240313152822.626493-6-vsementsov@yandex-team.ru>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 .../qemu-iotests/tests/backup-discard-source  | 152 ++++++++++++++++++
 .../tests/backup-discard-source.out           |   5 +
 2 files changed, 157 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/backup-discard-source
 create mode 100644 tests/qemu-iotests/tests/backup-discard-source.out

diff --git a/tests/qemu-iotests/tests/backup-discard-source b/tests/qemu-iotests/tests/backup-discard-source
new file mode 100755
index 0000000000..2391b12acd
--- /dev/null
+++ b/tests/qemu-iotests/tests/backup-discard-source
@@ -0,0 +1,152 @@
+#!/usr/bin/env python3
+#
+# Test backup discard-source parameter
+#
+# Copyright (c) Virtuozzo International GmbH.
+# Copyright (c) Yandex
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
+from iotests import qemu_img_create, qemu_img_map, qemu_io
+
+
+temp_img = os.path.join(iotests.test_dir, 'temp')
+source_img = os.path.join(iotests.test_dir, 'source')
+target_img = os.path.join(iotests.test_dir, 'target')
+size = '1M'
+
+
+def get_actual_size(vm, node_name):
+    nodes = vm.cmd('query-named-block-nodes', flat=True)
+    node = next(n for n in nodes if n['node-name'] == node_name)
+    return node['image']['actual-size']
+
+
+class TestBackup(iotests.QMPTestCase):
+    def setUp(self):
+        qemu_img_create('-f', iotests.imgfmt, source_img, size)
+        qemu_img_create('-f', iotests.imgfmt, temp_img, size)
+        qemu_img_create('-f', iotests.imgfmt, target_img, size)
+        qemu_io('-c', 'write 0 1M', source_img)
+
+        self.vm = iotests.VM()
+        self.vm.launch()
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'cbw',
+            'driver': 'copy-before-write',
+            'file': {
+                'driver': iotests.imgfmt,
+                'file': {
+                    'driver': 'file',
+                    'filename': source_img,
+                }
+            },
+            'target': {
+                'driver': iotests.imgfmt,
+                'discard': 'unmap',
+                'node-name': 'temp',
+                'file': {
+                    'driver': 'file',
+                    'filename': temp_img
+                }
+            }
+        })
+
+        self.vm.cmd('blockdev-add', {
+            'node-name': 'access',
+            'discard': 'unmap',
+            'driver': 'snapshot-access',
+            'file': 'cbw'
+        })
+
+        self.vm.cmd('blockdev-add', {
+            'driver': iotests.imgfmt,
+            'node-name': 'target',
+            'file': {
+                'driver': 'file',
+                'filename': target_img
+            }
+        })
+
+        self.assertLess(get_actual_size(self.vm, 'temp'), 512 * 1024)
+
+    def tearDown(self):
+        # That should fail, because region is discarded
+        self.vm.hmp_qemu_io('access', 'read 0 1M')
+
+        self.vm.shutdown()
+
+        self.assertTrue('read failed: Permission denied' in self.vm.get_log())
+
+        # Final check that temp image is empty
+        mapping = qemu_img_map(temp_img)
+        self.assertEqual(len(mapping), 1)
+        self.assertEqual(mapping[0]['start'], 0)
+        self.assertEqual(mapping[0]['length'], 1024 * 1024)
+        self.assertEqual(mapping[0]['data'], False)
+
+        os.remove(temp_img)
+        os.remove(source_img)
+        os.remove(target_img)
+
+    def do_backup(self):
+        self.vm.cmd('blockdev-backup', device='access',
+                    sync='full', target='target',
+                    job_id='backup0',
+                    discard_source=True)
+
+        self.vm.event_wait(name='BLOCK_JOB_COMPLETED')
+
+    def test_discard_written(self):
+        """
+        1. Guest writes
+        2. copy-before-write operation, data is stored to temp
+        3. start backup(discard_source=True), check that data is
+           removed from temp
+        """
+        # Trigger copy-before-write operation
+        result = self.vm.hmp_qemu_io('cbw', 'write 0 1M')
+        self.assert_qmp(result, 'return', '')
+
+        # Check that data is written to temporary image
+        self.assertGreater(get_actual_size(self.vm, 'temp'), 1024 * 1024)
+
+        self.do_backup()
+
+    def test_discard_cbw(self):
+        """
+        1. do backup(discard_source=True), which should inform
+           copy-before-write that data is not needed anymore
+        2. Guest writes
+        3. Check that copy-before-write operation is not done
+        """
+        self.do_backup()
+
+        # Try trigger copy-before-write operation
+        result = self.vm.hmp_qemu_io('cbw', 'write 0 1M')
+        self.assert_qmp(result, 'return', '')
+
+        # Check that data is not written to temporary image, as region
+        # is discarded from copy-before-write process
+        self.assertLess(get_actual_size(self.vm, 'temp'), 512 * 1024)
+
+
+if __name__ == '__main__':
+    iotests.main(supported_fmts=['qcow2'],
+                 supported_protocols=['file'])
diff --git a/tests/qemu-iotests/tests/backup-discard-source.out b/tests/qemu-iotests/tests/backup-discard-source.out
new file mode 100644
index 0000000000..fbc63e62f8
--- /dev/null
+++ b/tests/qemu-iotests/tests/backup-discard-source.out
@@ -0,0 +1,5 @@
+..
+----------------------------------------------------------------------
+Ran 2 tests
+
+OK
-- 
2.34.1


