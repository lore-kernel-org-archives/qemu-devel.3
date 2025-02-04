Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DF5C02198
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQH9-0006my-1N; Tue, 04 Feb 2025 16:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfQGM-0005kK-Lq
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:15:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfQGJ-0005yw-5t
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:15:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738703714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=avHUH+YE5G7nRDTUtTi4aEnyQGlh6f9K9ES9RLmlSrg=;
 b=C975q3jVDhXP894ID+zQsGrOISdVtIPRoj+meiTH6yZVgLxBOf/u91Qy9NQ3X1gredyJRA
 b3FnRxXduoHrbCvTuL07JZov53xn2gRnCRFof3UKl6GozYuhpvrLZaJOxR8mhMkmp53gMu
 ZkdYFbYp12KWBTUuiR10/9mh36/M2vU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-OOKzLZayOi-2MhqdmL0L0w-1; Tue,
 04 Feb 2025 16:15:12 -0500
X-MC-Unique: OOKzLZayOi-2MhqdmL0L0w-1
X-Mimecast-MFC-AGG-ID: OOKzLZayOi-2MhqdmL0L0w
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C36019560B7; Tue,  4 Feb 2025 21:15:11 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5B57C1800365; Tue,  4 Feb 2025 21:15:08 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v3 16/16] iotests: Add (NBD-based) tests for inactive nodes
Date: Tue,  4 Feb 2025 22:14:07 +0100
Message-ID: <20250204211407.381505-17-kwolf@redhat.com>
In-Reply-To: <20250204211407.381505-1-kwolf@redhat.com>
References: <20250204211407.381505-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This tests different types of operations on inactive block nodes
(including graph changes, block jobs and NBD exports) to make sure that
users manually activating and inactivating nodes doesn't break things.

Support for inactive nodes in other export types will have to come with
separate test cases because they have different dependencies like blkio
or root permissions and we don't want to disable this basic test when
they are not fulfilled.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py                 |   4 +
 tests/qemu-iotests/tests/inactive-node-nbd    | 303 ++++++++++++++++++
 .../qemu-iotests/tests/inactive-node-nbd.out  | 239 ++++++++++++++
 3 files changed, 546 insertions(+)
 create mode 100755 tests/qemu-iotests/tests/inactive-node-nbd
 create mode 100644 tests/qemu-iotests/tests/inactive-node-nbd.out

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 9c9c908983..7292c8b342 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -913,6 +913,10 @@ def add_incoming(self, addr):
         self._args.append(addr)
         return self
 
+    def add_paused(self):
+        self._args.append('-S')
+        return self
+
     def hmp(self, command_line: str, use_log: bool = False) -> QMPMessage:
         cmd = 'human-monitor-command'
         kwargs: Dict[str, Any] = {'command-line': command_line}
diff --git a/tests/qemu-iotests/tests/inactive-node-nbd b/tests/qemu-iotests/tests/inactive-node-nbd
new file mode 100755
index 0000000000..a95b37e796
--- /dev/null
+++ b/tests/qemu-iotests/tests/inactive-node-nbd
@@ -0,0 +1,303 @@
+#!/usr/bin/env python3
+# group: rw quick
+#
+# Copyright (C) Red Hat, Inc.
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
+import iotests
+
+from iotests import QemuIoInteractive
+from iotests import filter_qemu_io, filter_qtest, filter_qmp_testfiles
+
+iotests.script_initialize(supported_fmts=['generic'],
+                          supported_protocols=['file'],
+                          supported_platforms=['linux'])
+
+def get_export(node_name='disk-fmt', allow_inactive=None):
+    exp = {
+        'id': 'exp0',
+        'type': 'nbd',
+        'node-name': node_name,
+        'writable': True,
+    }
+
+    if allow_inactive is not None:
+        exp['allow-inactive'] = allow_inactive
+
+    return exp
+
+def node_is_active(_vm, node_name):
+    nodes = _vm.cmd('query-named-block-nodes', flat=True)
+    node = next(n for n in nodes if n['node-name'] == node_name)
+    return node['active']
+
+with iotests.FilePath('disk.img') as path, \
+     iotests.FilePath('snap.qcow2') as snap_path, \
+     iotests.FilePath('snap2.qcow2') as snap2_path, \
+     iotests.FilePath('target.img') as target_path, \
+     iotests.FilePath('nbd.sock', base_dir=iotests.sock_dir) as nbd_sock, \
+     iotests.VM() as vm:
+
+    img_size = '10M'
+
+    iotests.log('Preparing disk...')
+    iotests.qemu_img_create('-f', iotests.imgfmt, path, img_size)
+    iotests.qemu_img_create('-f', iotests.imgfmt, target_path, img_size)
+
+    iotests.qemu_img_create('-f', 'qcow2', '-b', path, '-F', iotests.imgfmt,
+                            snap_path)
+    iotests.qemu_img_create('-f', 'qcow2', '-b', snap_path, '-F', 'qcow2',
+                            snap2_path)
+
+    iotests.log('Launching VM...')
+    vm.add_blockdev(f'file,node-name=disk-file,filename={path}')
+    vm.add_blockdev(f'{iotests.imgfmt},file=disk-file,node-name=disk-fmt,'
+                     'active=off')
+    vm.add_blockdev(f'file,node-name=target-file,filename={target_path}')
+    vm.add_blockdev(f'{iotests.imgfmt},file=target-file,node-name=target-fmt')
+    vm.add_blockdev(f'file,node-name=snap-file,filename={snap_path}')
+    vm.add_blockdev(f'file,node-name=snap2-file,filename={snap2_path}')
+
+    # Actually running the VM activates all images
+    vm.add_paused()
+
+    vm.launch()
+    vm.qmp_log('nbd-server-start',
+                addr={'type': 'unix', 'data':{'path': nbd_sock}},
+                filters=[filter_qmp_testfiles])
+
+    iotests.log('\n=== Creating export of inactive node ===')
+
+    iotests.log('\nExports activate nodes without allow-inactive')
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    vm.qmp_log('block-export-add', **get_export())
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    vm.qmp_log('query-block-exports')
+    vm.qmp_log('block-export-del', id='exp0')
+    vm.event_wait('BLOCK_EXPORT_DELETED')
+    vm.qmp_log('query-block-exports')
+
+    iotests.log('\nExports activate nodes with allow-inactive=false')
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=False)
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    vm.qmp_log('block-export-add', **get_export(allow_inactive=False))
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    vm.qmp_log('query-block-exports')
+    vm.qmp_log('block-export-del', id='exp0')
+    vm.event_wait('BLOCK_EXPORT_DELETED')
+    vm.qmp_log('query-block-exports')
+
+    iotests.log('\nExport leaves nodes inactive with allow-inactive=true')
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=False)
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    vm.qmp_log('block-export-add', **get_export(allow_inactive=True))
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    vm.qmp_log('query-block-exports')
+    vm.qmp_log('block-export-del', id='exp0')
+    vm.event_wait('BLOCK_EXPORT_DELETED')
+    vm.qmp_log('query-block-exports')
+
+    iotests.log('\n=== Inactivating node with existing export ===')
+
+    iotests.log('\nInactivating nodes with an export fails without '
+                'allow-inactive')
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=True)
+    vm.qmp_log('block-export-add', **get_export(node_name='disk-fmt'))
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=False)
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    vm.qmp_log('query-block-exports')
+    vm.qmp_log('block-export-del', id='exp0')
+    vm.event_wait('BLOCK_EXPORT_DELETED')
+    vm.qmp_log('query-block-exports')
+
+    iotests.log('\nInactivating nodes with an export fails with '
+                'allow-inactive=false')
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=True)
+    vm.qmp_log('block-export-add',
+               **get_export(node_name='disk-fmt', allow_inactive=False))
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=False)
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    vm.qmp_log('query-block-exports')
+    vm.qmp_log('block-export-del', id='exp0')
+    vm.event_wait('BLOCK_EXPORT_DELETED')
+    vm.qmp_log('query-block-exports')
+
+    iotests.log('\nInactivating nodes with an export works with '
+                'allow-inactive=true')
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=True)
+    vm.qmp_log('block-export-add',
+               **get_export(node_name='disk-fmt', allow_inactive=True))
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=False)
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    vm.qmp_log('query-block-exports')
+    vm.qmp_log('block-export-del', id='exp0')
+    vm.event_wait('BLOCK_EXPORT_DELETED')
+    vm.qmp_log('query-block-exports')
+
+    iotests.log('\n=== Inactive nodes with parent ===')
+
+    iotests.log('\nInactivating nodes with an active parent fails')
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=True)
+    vm.qmp_log('blockdev-set-active', node_name='disk-file', active=False)
+    iotests.log('disk-file active: %s' % node_is_active(vm, 'disk-file'))
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+
+    iotests.log('\nInactivating nodes with an inactive parent works')
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=False)
+    vm.qmp_log('blockdev-set-active', node_name='disk-file', active=False)
+    iotests.log('disk-file active: %s' % node_is_active(vm, 'disk-file'))
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+
+    iotests.log('\nCreating active parent node with an inactive child fails')
+    vm.qmp_log('blockdev-add', driver='raw', file='disk-fmt',
+               node_name='disk-filter')
+    vm.qmp_log('blockdev-add', driver='raw', file='disk-fmt',
+               node_name='disk-filter', active=True)
+
+    iotests.log('\nCreating inactive parent node with an inactive child works')
+    vm.qmp_log('blockdev-add', driver='raw', file='disk-fmt',
+               node_name='disk-filter', active=False)
+    vm.qmp_log('blockdev-del', node_name='disk-filter')
+
+    iotests.log('\n=== Resizing an inactive node ===')
+    vm.qmp_log('block_resize', node_name='disk-fmt', size=16*1024*1024)
+
+    iotests.log('\n=== Taking a snapshot of an inactive node ===')
+
+    iotests.log('\nActive overlay over inactive backing file automatically '
+                'makes both inactive for compatibility')
+    vm.qmp_log('blockdev-add', driver='qcow2', node_name='snap-fmt',
+               file='snap-file', backing=None)
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    iotests.log('snap-fmt active: %s' % node_is_active(vm, 'snap-fmt'))
+    vm.qmp_log('blockdev-snapshot', node='disk-fmt', overlay='snap-fmt')
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    iotests.log('snap-fmt active: %s' % node_is_active(vm, 'snap-fmt'))
+    vm.qmp_log('blockdev-del', node_name='snap-fmt')
+
+    iotests.log('\nInactive overlay over inactive backing file just works')
+    vm.qmp_log('blockdev-add', driver='qcow2', node_name='snap-fmt',
+               file='snap-file', backing=None, active=False)
+    vm.qmp_log('blockdev-snapshot', node='disk-fmt', overlay='snap-fmt')
+
+    iotests.log('\n=== Block jobs with inactive nodes ===')
+
+    iotests.log('\nStreaming into an inactive node')
+    vm.qmp_log('block-stream', device='snap-fmt',
+               filters=[iotests.filter_qmp_generated_node_ids])
+
+    iotests.log('\nCommitting an inactive root node (active commit)')
+    vm.qmp_log('block-commit', job_id='job0', device='snap-fmt',
+               filters=[iotests.filter_qmp_generated_node_ids])
+
+    iotests.log('\nCommitting an inactive intermediate node to inactive base')
+    vm.qmp_log('blockdev-add', driver='qcow2', node_name='snap2-fmt',
+               file='snap2-file', backing='snap-fmt', active=False)
+
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    iotests.log('snap-fmt active: %s' % node_is_active(vm, 'snap-fmt'))
+    iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
+
+    vm.qmp_log('block-commit', job_id='job0', device='snap2-fmt',
+               top_node='snap-fmt',
+               filters=[iotests.filter_qmp_generated_node_ids])
+
+    iotests.log('\nCommitting an inactive intermediate node to active base')
+    vm.qmp_log('blockdev-set-active', node_name='disk-fmt', active=True)
+    vm.qmp_log('block-commit', job_id='job0', device='snap2-fmt',
+               top_node='snap-fmt',
+               filters=[iotests.filter_qmp_generated_node_ids])
+
+    iotests.log('\nMirror from inactive source to active target')
+    vm.qmp_log('blockdev-mirror', job_id='job0', device='snap2-fmt',
+               target='target-fmt', sync='full',
+               filters=[iotests.filter_qmp_generated_node_ids])
+
+    iotests.log('\nMirror from active source to inactive target')
+
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    iotests.log('snap-fmt active: %s' % node_is_active(vm, 'snap-fmt'))
+    iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
+    iotests.log('target-fmt active: %s' % node_is_active(vm, 'target-fmt'))
+
+    # Activating snap2-fmt recursively activates the whole backing chain
+    vm.qmp_log('blockdev-set-active', node_name='snap2-fmt', active=True)
+    vm.qmp_log('blockdev-set-active', node_name='target-fmt', active=False)
+
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    iotests.log('snap-fmt active: %s' % node_is_active(vm, 'snap-fmt'))
+    iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
+    iotests.log('target-fmt active: %s' % node_is_active(vm, 'target-fmt'))
+
+    vm.qmp_log('blockdev-mirror', job_id='job0', device='snap2-fmt',
+               target='target-fmt', sync='full',
+               filters=[iotests.filter_qmp_generated_node_ids])
+
+    iotests.log('\nBackup from active source to inactive target')
+
+    vm.qmp_log('blockdev-backup', job_id='job0', device='snap2-fmt',
+               target='target-fmt', sync='full',
+               filters=[iotests.filter_qmp_generated_node_ids])
+
+    iotests.log('\nBackup from inactive source to active target')
+
+    # Inactivating snap2-fmt recursively inactivates the whole backing chain
+    vm.qmp_log('blockdev-set-active', node_name='snap2-fmt', active=False)
+    vm.qmp_log('blockdev-set-active', node_name='target-fmt', active=True)
+
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    iotests.log('snap-fmt active: %s' % node_is_active(vm, 'snap-fmt'))
+    iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
+    iotests.log('target-fmt active: %s' % node_is_active(vm, 'target-fmt'))
+
+    vm.qmp_log('blockdev-backup', job_id='job0', device='snap2-fmt',
+               target='target-fmt', sync='full',
+               filters=[iotests.filter_qmp_generated_node_ids])
+
+    iotests.log('\n=== Accessing export on inactive node ===')
+
+    # Use the target node because it has the right image format and isn't the
+    # (read-only) backing file of a qcow2 node
+    vm.qmp_log('blockdev-set-active', node_name='target-fmt', active=False)
+    vm.qmp_log('block-export-add',
+               **get_export(node_name='target-fmt', allow_inactive=True))
+
+    # The read should succeed, everything else should fail gracefully
+    qemu_io = QemuIoInteractive('-f', 'raw',
+                                f'nbd+unix:///target-fmt?socket={nbd_sock}')
+    iotests.log(qemu_io.cmd('read 0 64k'), filters=[filter_qemu_io])
+    iotests.log(qemu_io.cmd('write 0 64k'), filters=[filter_qemu_io])
+    iotests.log(qemu_io.cmd('write -z 0 64k'), filters=[filter_qemu_io])
+    iotests.log(qemu_io.cmd('write -zu 0 64k'), filters=[filter_qemu_io])
+    iotests.log(qemu_io.cmd('discard 0 64k'), filters=[filter_qemu_io])
+    iotests.log(qemu_io.cmd('flush'), filters=[filter_qemu_io])
+    iotests.log(qemu_io.cmd('map'), filters=[filter_qemu_io])
+    qemu_io.close()
+
+    iotests.log('\n=== Resuming VM activates all images ===')
+    vm.qmp_log('cont')
+
+    iotests.log('disk-fmt active: %s' % node_is_active(vm, 'disk-fmt'))
+    iotests.log('snap-fmt active: %s' % node_is_active(vm, 'snap-fmt'))
+    iotests.log('snap2-fmt active: %s' % node_is_active(vm, 'snap2-fmt'))
+    iotests.log('target-fmt active: %s' % node_is_active(vm, 'target-fmt'))
+
+    iotests.log('\nShutting down...')
+    vm.shutdown()
+    log = vm.get_log()
+    if log:
+        iotests.log(log, [filter_qtest, filter_qemu_io])
diff --git a/tests/qemu-iotests/tests/inactive-node-nbd.out b/tests/qemu-iotests/tests/inactive-node-nbd.out
new file mode 100644
index 0000000000..a458b4fc05
--- /dev/null
+++ b/tests/qemu-iotests/tests/inactive-node-nbd.out
@@ -0,0 +1,239 @@
+Preparing disk...
+Launching VM...
+{"execute": "nbd-server-start", "arguments": {"addr": {"data": {"path": "SOCK_DIR/PID-nbd.sock"}, "type": "unix"}}}
+{"return": {}}
+
+=== Creating export of inactive node ===
+
+Exports activate nodes without allow-inactive
+disk-fmt active: False
+{"execute": "block-export-add", "arguments": {"id": "exp0", "node-name": "disk-fmt", "type": "nbd", "writable": true}}
+{"return": {}}
+disk-fmt active: True
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "exp0", "node-name": "disk-fmt", "shutting-down": false, "type": "nbd"}]}
+{"execute": "block-export-del", "arguments": {"id": "exp0"}}
+{"return": {}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": []}
+
+Exports activate nodes with allow-inactive=false
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "disk-fmt"}}
+{"return": {}}
+disk-fmt active: False
+{"execute": "block-export-add", "arguments": {"allow-inactive": false, "id": "exp0", "node-name": "disk-fmt", "type": "nbd", "writable": true}}
+{"return": {}}
+disk-fmt active: True
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "exp0", "node-name": "disk-fmt", "shutting-down": false, "type": "nbd"}]}
+{"execute": "block-export-del", "arguments": {"id": "exp0"}}
+{"return": {}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": []}
+
+Export leaves nodes inactive with allow-inactive=true
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "disk-fmt"}}
+{"return": {}}
+disk-fmt active: False
+{"execute": "block-export-add", "arguments": {"allow-inactive": true, "id": "exp0", "node-name": "disk-fmt", "type": "nbd", "writable": true}}
+{"return": {}}
+disk-fmt active: False
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "exp0", "node-name": "disk-fmt", "shutting-down": false, "type": "nbd"}]}
+{"execute": "block-export-del", "arguments": {"id": "exp0"}}
+{"return": {}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": []}
+
+=== Inactivating node with existing export ===
+
+Inactivating nodes with an export fails without allow-inactive
+{"execute": "blockdev-set-active", "arguments": {"active": true, "node-name": "disk-fmt"}}
+{"return": {}}
+{"execute": "block-export-add", "arguments": {"id": "exp0", "node-name": "disk-fmt", "type": "nbd", "writable": true}}
+{"return": {}}
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "disk-fmt"}}
+{"error": {"class": "GenericError", "desc": "Failed to inactivate node: Operation not permitted"}}
+disk-fmt active: True
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "exp0", "node-name": "disk-fmt", "shutting-down": false, "type": "nbd"}]}
+{"execute": "block-export-del", "arguments": {"id": "exp0"}}
+{"return": {}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": []}
+
+Inactivating nodes with an export fails with allow-inactive=false
+{"execute": "blockdev-set-active", "arguments": {"active": true, "node-name": "disk-fmt"}}
+{"return": {}}
+{"execute": "block-export-add", "arguments": {"allow-inactive": false, "id": "exp0", "node-name": "disk-fmt", "type": "nbd", "writable": true}}
+{"return": {}}
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "disk-fmt"}}
+{"error": {"class": "GenericError", "desc": "Failed to inactivate node: Operation not permitted"}}
+disk-fmt active: True
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "exp0", "node-name": "disk-fmt", "shutting-down": false, "type": "nbd"}]}
+{"execute": "block-export-del", "arguments": {"id": "exp0"}}
+{"return": {}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": []}
+
+Inactivating nodes with an export works with allow-inactive=true
+{"execute": "blockdev-set-active", "arguments": {"active": true, "node-name": "disk-fmt"}}
+{"return": {}}
+{"execute": "block-export-add", "arguments": {"allow-inactive": true, "id": "exp0", "node-name": "disk-fmt", "type": "nbd", "writable": true}}
+{"return": {}}
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "disk-fmt"}}
+{"return": {}}
+disk-fmt active: False
+{"execute": "query-block-exports", "arguments": {}}
+{"return": [{"id": "exp0", "node-name": "disk-fmt", "shutting-down": false, "type": "nbd"}]}
+{"execute": "block-export-del", "arguments": {"id": "exp0"}}
+{"return": {}}
+{"execute": "query-block-exports", "arguments": {}}
+{"return": []}
+
+=== Inactive nodes with parent ===
+
+Inactivating nodes with an active parent fails
+{"execute": "blockdev-set-active", "arguments": {"active": true, "node-name": "disk-fmt"}}
+{"return": {}}
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "disk-file"}}
+{"error": {"class": "GenericError", "desc": "Node has active parent node"}}
+disk-file active: True
+disk-fmt active: True
+
+Inactivating nodes with an inactive parent works
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "disk-fmt"}}
+{"return": {}}
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "disk-file"}}
+{"return": {}}
+disk-file active: False
+disk-fmt active: False
+
+Creating active parent node with an inactive child fails
+{"execute": "blockdev-add", "arguments": {"driver": "raw", "file": "disk-fmt", "node-name": "disk-filter"}}
+{"error": {"class": "GenericError", "desc": "Inactive 'disk-fmt' can't be a file child of active 'disk-filter'"}}
+{"execute": "blockdev-add", "arguments": {"active": true, "driver": "raw", "file": "disk-fmt", "node-name": "disk-filter"}}
+{"error": {"class": "GenericError", "desc": "Inactive 'disk-fmt' can't be a file child of active 'disk-filter'"}}
+
+Creating inactive parent node with an inactive child works
+{"execute": "blockdev-add", "arguments": {"active": false, "driver": "raw", "file": "disk-fmt", "node-name": "disk-filter"}}
+{"return": {}}
+{"execute": "blockdev-del", "arguments": {"node-name": "disk-filter"}}
+{"return": {}}
+
+=== Resizing an inactive node ===
+{"execute": "block_resize", "arguments": {"node-name": "disk-fmt", "size": 16777216}}
+{"error": {"class": "GenericError", "desc": "Permission 'resize' unavailable on inactive node"}}
+
+=== Taking a snapshot of an inactive node ===
+
+Active overlay over inactive backing file automatically makes both inactive for compatibility
+{"execute": "blockdev-add", "arguments": {"backing": null, "driver": "qcow2", "file": "snap-file", "node-name": "snap-fmt"}}
+{"return": {}}
+disk-fmt active: False
+snap-fmt active: True
+{"execute": "blockdev-snapshot", "arguments": {"node": "disk-fmt", "overlay": "snap-fmt"}}
+{"return": {}}
+disk-fmt active: False
+snap-fmt active: False
+{"execute": "blockdev-del", "arguments": {"node-name": "snap-fmt"}}
+{"return": {}}
+
+Inactive overlay over inactive backing file just works
+{"execute": "blockdev-add", "arguments": {"active": false, "backing": null, "driver": "qcow2", "file": "snap-file", "node-name": "snap-fmt"}}
+{"return": {}}
+{"execute": "blockdev-snapshot", "arguments": {"node": "disk-fmt", "overlay": "snap-fmt"}}
+{"return": {}}
+
+=== Block jobs with inactive nodes ===
+
+Streaming into an inactive node
+{"execute": "block-stream", "arguments": {"device": "snap-fmt"}}
+{"error": {"class": "GenericError", "desc": "Could not create node: Inactive 'snap-fmt' can't be a file child of active 'NODE_NAME'"}}
+
+Committing an inactive root node (active commit)
+{"execute": "block-commit", "arguments": {"device": "snap-fmt", "job-id": "job0"}}
+{"error": {"class": "GenericError", "desc": "Inactive 'snap-fmt' can't be a backing child of active 'NODE_NAME'"}}
+
+Committing an inactive intermediate node to inactive base
+{"execute": "blockdev-add", "arguments": {"active": false, "backing": "snap-fmt", "driver": "qcow2", "file": "snap2-file", "node-name": "snap2-fmt"}}
+{"return": {}}
+disk-fmt active: False
+snap-fmt active: False
+snap2-fmt active: False
+{"execute": "block-commit", "arguments": {"device": "snap2-fmt", "job-id": "job0", "top-node": "snap-fmt"}}
+{"error": {"class": "GenericError", "desc": "Inactive 'snap-fmt' can't be a backing child of active 'NODE_NAME'"}}
+
+Committing an inactive intermediate node to active base
+{"execute": "blockdev-set-active", "arguments": {"active": true, "node-name": "disk-fmt"}}
+{"return": {}}
+{"execute": "block-commit", "arguments": {"device": "snap2-fmt", "job-id": "job0", "top-node": "snap-fmt"}}
+{"error": {"class": "GenericError", "desc": "Inactive 'snap-fmt' can't be a backing child of active 'NODE_NAME'"}}
+
+Mirror from inactive source to active target
+{"execute": "blockdev-mirror", "arguments": {"device": "snap2-fmt", "job-id": "job0", "sync": "full", "target": "target-fmt"}}
+{"error": {"class": "GenericError", "desc": "Inactive 'snap2-fmt' can't be a backing child of active 'NODE_NAME'"}}
+
+Mirror from active source to inactive target
+disk-fmt active: True
+snap-fmt active: False
+snap2-fmt active: False
+target-fmt active: True
+{"execute": "blockdev-set-active", "arguments": {"active": true, "node-name": "snap2-fmt"}}
+{"return": {}}
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "target-fmt"}}
+{"return": {}}
+disk-fmt active: True
+snap-fmt active: True
+snap2-fmt active: True
+target-fmt active: False
+{"execute": "blockdev-mirror", "arguments": {"device": "snap2-fmt", "job-id": "job0", "sync": "full", "target": "target-fmt"}}
+{"error": {"class": "GenericError", "desc": "Permission 'write' unavailable on inactive node"}}
+
+Backup from active source to inactive target
+{"execute": "blockdev-backup", "arguments": {"device": "snap2-fmt", "job-id": "job0", "sync": "full", "target": "target-fmt"}}
+{"error": {"class": "GenericError", "desc": "Could not create node: Inactive 'target-fmt' can't be a target child of active 'NODE_NAME'"}}
+
+Backup from inactive source to active target
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "snap2-fmt"}}
+{"return": {}}
+{"execute": "blockdev-set-active", "arguments": {"active": true, "node-name": "target-fmt"}}
+{"return": {}}
+disk-fmt active: False
+snap-fmt active: False
+snap2-fmt active: False
+target-fmt active: True
+{"execute": "blockdev-backup", "arguments": {"device": "snap2-fmt", "job-id": "job0", "sync": "full", "target": "target-fmt"}}
+{"error": {"class": "GenericError", "desc": "Could not create node: Inactive 'snap2-fmt' can't be a file child of active 'NODE_NAME'"}}
+
+=== Accessing export on inactive node ===
+{"execute": "blockdev-set-active", "arguments": {"active": false, "node-name": "target-fmt"}}
+{"return": {}}
+{"execute": "block-export-add", "arguments": {"allow-inactive": true, "id": "exp0", "node-name": "target-fmt", "type": "nbd", "writable": true}}
+{"return": {}}
+read 65536/65536 bytes at offset 0
+64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+write failed: Operation not permitted
+
+write failed: Operation not permitted
+
+write failed: Operation not permitted
+
+discard failed: Operation not permitted
+
+
+qemu-io: Failed to get allocation status: Operation not permitted
+
+
+=== Resuming VM activates all images ===
+{"execute": "cont", "arguments": {}}
+{"return": {}}
+disk-fmt active: True
+snap-fmt active: True
+snap2-fmt active: True
+target-fmt active: True
+
+Shutting down...
+
-- 
2.48.1


