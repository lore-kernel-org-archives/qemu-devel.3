Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0C3F3D5E1
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 13:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9NGu-0006ln-68; Sun, 05 Apr 2026 09:12:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9NGX-0006Z7-Q3
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 09:11:50 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9NGV-0006eT-Tx
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 09:11:49 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 346656001A;
 Sun,  5 Apr 2026 13:11:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C50C19425;
 Sun,  5 Apr 2026 13:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775394706;
 bh=rGuDObTpmf98oV2ZmtxPCkCI9kEJVPL11Kaao5hwhXQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AagrvpDXOijl9aLYUd8IM+C08U7TRDDDTBTEmDWQ/DyjO90Ub/tQ8j2ZZZSnzxKri
 HQyojvDvzLznbsOpkR91SjIBWNlCsKHjC529Hssq8dkLa2uX9emQ4BMaRcMRSRW8FC
 nhC4yOvLg3wNjbZwDhJyxX+m+g9jTjb6hV5el21vlkEbZfK3HPN9tvkNDhcc1RQvVv
 HRJBsEjRIBHoD0OQsmh7a6Q3o99ZymfvTbzVHeOIatkz1Hug/KkNvPCQcVxwJ4GWpo
 5ZlgbQ9LgTkuUQS0OwnPiGACZFroB5a31Ykmlq7QpNHF/pAEzanzQi0rAnEDvcSHLA
 jSVkg5sqIXqNQ==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 05 Apr 2026 15:11:21 +0200
Subject: [PATCH v2 5/5] tests/functional: add e2e test for dynamic QMP
 monitor hotplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260405-work-qmp-monitor-hotplug-v2-5-ad5bedd2917a@kernel.org>
References: <20260405-work-qmp-monitor-hotplug-v2-0-ad5bedd2917a@kernel.org>
In-Reply-To: <20260405-work-qmp-monitor-hotplug-v2-0-ad5bedd2917a@kernel.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7861; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rGuDObTpmf98oV2ZmtxPCkCI9kEJVPL11Kaao5hwhXQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWReim/y2Ht8Iue9GoZo/4N5zNPZmtNv/K3fJPa61Ls48
 MAeLf5PHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxWsrwh2fViwtrzrM+d7s4
 ofmhzuJZZy22vjDKPfv/9pIwj9+91lMYGVYsjH3XUWUt/it8VlDt42+7WM5otsSenllVXNHR271
 XjhcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Received-SPF: pass client-ip=172.105.4.254; envelope-from=brauner@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add functional tests that exercise dynamic monitor hotplug with real
socket connections:

- Hotplug cycle: chardev-add a unix socket, monitor-add, connect to the
  socket, receive the QMP greeting, negotiate capabilities, send
  query-version, disconnect, remove the monitor and chardev, then repeat
  the entire cycle a second time to verify cleanup and reuse.

- Self-removal: a dynamically-added monitor sends monitor-remove
  targeting itself, verifying that the response is delivered before
  the connection drops and that the monitor is gone afterwards.

- Large response: send query-qmp-schema on a dynamic monitor to
  exercise the output buffer flush path with a large response payload.

- Events after negotiation: trigger STOP/RESUME events via the main
  monitor and verify they are delivered on the dynamic monitor.

This complements the qtest unit tests by verifying that a real QMP
client can connect to a dynamically-added monitor and exchange messages.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 tests/functional/generic/meson.build             |   1 +
 tests/functional/generic/test_monitor_hotplug.py | 183 +++++++++++++++++++++++
 2 files changed, 184 insertions(+)

diff --git a/tests/functional/generic/meson.build b/tests/functional/generic/meson.build
index 09763c5d22..c94105c62e 100644
--- a/tests/functional/generic/meson.build
+++ b/tests/functional/generic/meson.build
@@ -4,6 +4,7 @@ tests_generic_system = [
   'empty_cpu_model',
   'info_usernet',
   'linters',
+  'monitor_hotplug',
   'version',
   'vnc',
 ]
diff --git a/tests/functional/generic/test_monitor_hotplug.py b/tests/functional/generic/test_monitor_hotplug.py
new file mode 100644
index 0000000000..d65d33c2f6
--- /dev/null
+++ b/tests/functional/generic/test_monitor_hotplug.py
@@ -0,0 +1,183 @@
+#!/usr/bin/env python3
+#
+# Functional test for dynamic QMP monitor hotplug
+#
+# Copyright (c) 2026 Christian Brauner
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import os
+import tempfile
+
+from qemu.qmp.legacy import QEMUMonitorProtocol
+
+from qemu_test import QemuSystemTest
+
+
+class MonitorHotplug(QemuSystemTest):
+
+    def setUp(self):
+        super().setUp()
+        # Use /tmp to avoid UNIX socket path length limit (108 bytes).
+        # The scratch_file() path is too deep for socket names.
+        fd, self._sock_path = tempfile.mkstemp(
+            prefix='qemu-mon-', suffix='.sock')
+        os.close(fd)
+        os.unlink(self._sock_path)
+
+    def tearDown(self):
+        try:
+            os.unlink(self._sock_path)
+        except FileNotFoundError:
+            pass
+        super().tearDown()
+
+    def _add_monitor(self):
+        """Create a chardev + monitor and return the socket path."""
+        sock = self._sock_path
+        self.vm.cmd('chardev-add', id='hotplug-chr', backend={
+            'type': 'socket',
+            'data': {
+                'addr': {
+                    'type': 'unix',
+                    'data': {'path': sock}
+                },
+                'server': True,
+                'wait': False,
+            }
+        })
+        self.vm.cmd('monitor-add', id='hotplug-mon',
+                    chardev='hotplug-chr')
+        return sock
+
+    def _remove_monitor(self):
+        """Remove the monitor + chardev."""
+        self.vm.cmd('monitor-remove', id='hotplug-mon')
+        self.vm.cmd('chardev-remove', id='hotplug-chr')
+
+    def _connect_and_handshake(self, sock_path):
+        """
+        Connect to the dynamic monitor socket, perform the QMP
+        greeting and capability negotiation, send a command, then
+        disconnect.
+        """
+        qmp = QEMUMonitorProtocol(sock_path)
+
+        # connect(negotiate=True) receives the greeting, validates it,
+        # and sends qmp_capabilities automatically.
+        greeting = qmp.connect(negotiate=True)
+        self.assertIn('QMP', greeting)
+        self.assertIn('version', greeting['QMP'])
+        self.assertIn('capabilities', greeting['QMP'])
+
+        # Send a real command to prove the session is fully functional
+        resp = qmp.cmd_obj({'execute': 'query-version'})
+        self.assertIn('return', resp)
+        self.assertIn('qemu', resp['return'])
+
+        qmp.close()
+
+    def test_hotplug_cycle(self):
+        """
+        Hotplug a monitor, do the full QMP handshake, unplug it,
+        then repeat the whole cycle a second time.
+        """
+        self.set_machine('none')
+        self.vm.add_args('-nodefaults')
+        self.vm.launch()
+
+        # First cycle
+        sock = self._add_monitor()
+        self._connect_and_handshake(sock)
+        self._remove_monitor()
+
+        # Second cycle -- same ids, same path, must work
+        sock = self._add_monitor()
+        self._connect_and_handshake(sock)
+        self._remove_monitor()
+
+    def test_self_removal(self):
+        """
+        A dynamically-added monitor sends monitor-remove targeting
+        itself.  Verify the response is delivered before the
+        connection drops, and that the monitor is gone afterwards.
+        """
+        self.set_machine('none')
+        self.vm.add_args('-nodefaults')
+        self.vm.launch()
+
+        sock = self._add_monitor()
+
+        qmp = QEMUMonitorProtocol(sock)
+        greeting = qmp.connect(negotiate=True)
+        self.assertIn('QMP', greeting)
+
+        # Self-removal: the dynamic monitor removes itself
+        resp = qmp.cmd_obj({'execute': 'monitor-remove',
+                            'arguments': {'id': 'hotplug-mon'}})
+        self.assertIn('return', resp)
+
+        qmp.close()
+
+        # The main monitor should no longer list the removed monitor
+        monitors = self.vm.cmd('query-monitors')
+        for m in monitors:
+            self.assertNotEqual(m.get('id'), 'hotplug-mon')
+
+        # Clean up the chardev
+        self.vm.cmd('chardev-remove', id='hotplug-chr')
+
+    def test_large_response(self):
+        """
+        Send a command with a large response (query-qmp-schema) on a
+        dynamically-added monitor to exercise the output buffer flush
+        path.
+        """
+        self.set_machine('none')
+        self.vm.add_args('-nodefaults')
+        self.vm.launch()
+
+        sock = self._add_monitor()
+
+        qmp = QEMUMonitorProtocol(sock)
+        qmp.connect(negotiate=True)
+
+        resp = qmp.cmd_obj({'execute': 'query-qmp-schema'})
+        self.assertIn('return', resp)
+        self.assertIsInstance(resp['return'], list)
+        self.assertGreater(len(resp['return']), 0)
+
+        qmp.close()
+        self._remove_monitor()
+
+    def test_events_after_negotiation(self):
+        """
+        Verify that QMP events are delivered on a dynamically-added
+        monitor after capability negotiation completes.
+        """
+        self.set_machine('none')
+        self.vm.add_args('-nodefaults')
+        self.vm.launch()
+
+        sock = self._add_monitor()
+
+        qmp = QEMUMonitorProtocol(sock)
+        qmp.connect(negotiate=True)
+
+        # Trigger a STOP event via the main monitor, then read it
+        # from the dynamic monitor.
+        self.vm.cmd('stop')
+        resp = qmp.pull_event(wait=True)
+        self.assertEqual(resp['event'], 'STOP')
+
+        self.vm.cmd('cont')
+        resp = qmp.pull_event(wait=True)
+        self.assertEqual(resp['event'], 'RESUME')
+
+        qmp.close()
+        self._remove_monitor()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()

-- 
2.47.3


