Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FE0C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 11:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3aT-0002il-Rj; Tue, 07 Jul 2026 07:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3aD-0002OZ-9B
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wh3a6-00087e-AJ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 07:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783422193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zcaT/nTF2k1lkJ1KZfsj+pUH8N1biu6WcS4H6JcsgPk=;
 b=N0dvaL3kfyBwDeioUdfY11al8CwiGQwJpbyitQvwJPDdStfuPoHSEFFJVki8DRN/Vx8W1j
 Zaoho4EWcDeMF67Koiyfh/t7LcQ2A7p4M+iCR5/SbVBFvebGl9DIDyYnxwMOiO3L9t0Nou
 Bmq0RoP0kMhIeSIsveKFT8oU8kGDsC8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-ZBOxBA7jMdKbHGioo9Dw0g-1; Tue,
 07 Jul 2026 07:03:12 -0400
X-MC-Unique: ZBOxBA7jMdKbHGioo9Dw0g-1
X-Mimecast-MFC-AGG-ID: ZBOxBA7jMdKbHGioo9Dw0g_1783422191
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 583F21954B17; Tue,  7 Jul 2026 11:03:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CECD718005B5; Tue,  7 Jul 2026 11:03:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1719E21E61BB; Tue, 07 Jul 2026 13:03:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Christian Brauner <brauner@kernel.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 29/35] tests/functional: add e2e test for dynamic QMP monitor
 hotplug
Date: Tue,  7 Jul 2026 13:02:54 +0200
Message-ID: <20260707110300.1918153-30-armbru@redhat.com>
In-Reply-To: <20260707110300.1918153-1-armbru@redhat.com>
References: <20260707110300.1918153-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

From: Christian Brauner <brauner@kernel.org>

Add functional tests that exercise dynamic monitor hotplug with real
socket connections:

- Hotplug cycle: chardev-add a unix socket, object-add, connect to the
  socket, receive the QMP greeting, negotiate capabilities, send
  query-version, disconnect, remove the monitor and chardev, then repeat
  the entire cycle a second time to verify cleanup and reuse.

- Self-removal: a dynamically-added monitor sends object-del
  targeting itself, verifying that the request is rejected

- Large response: send query-qmp-schema on a dynamic monitor to
  exercise the output buffer flush path with a large response payload.

- Events after negotiation: trigger STOP/RESUME events via the main
  monitor and verify they are delivered on the dynamic monitor.

This complements the qtest unit tests by verifying that a real QMP
client can connect to a dynamically-added monitor and exchange messages.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[DB: modified to use object-add/object-del; adjust self-removal test
 to validate rejection of request]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Tested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260706135824.2623960-30-berrange@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 MAINTAINERS                                   |   1 +
 tests/functional/generic/meson.build          |   1 +
 .../generic/test_monitor_hotplug.py           | 168 ++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100755 tests/functional/generic/test_monitor_hotplug.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e239f2116..10352b2633 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3672,6 +3672,7 @@ F: docs/interop/*qmp-*
 F: scripts/qmp/
 F: tests/qtest/qmp-test.c
 F: tests/qtest/qmp-cmd-test.c
+F: tests/functional/generic/test_monitor_hotplug.py
 T: git https://repo.or.cz/qemu/armbru.git qapi-next
 
 qtest
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
new file mode 100755
index 0000000000..5d8a159eb0
--- /dev/null
+++ b/tests/functional/generic/test_monitor_hotplug.py
@@ -0,0 +1,168 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# Functional test for dynamic QMP monitor hotplug
+#
+# Copyright (c) 2026 Christian Brauner
+
+import os
+
+from qemu_test import QemuSystemTest
+
+from qemu.qmp.legacy import QEMUMonitorProtocol
+
+
+class MonitorHotplug(QemuSystemTest):
+
+    def setUp(self):
+        super().setUp()
+        sock_dir = self.socket_dir()
+        self._sock_path = os.path.join(sock_dir.name, 'hotplug.sock')
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
+        self.vm.cmd('object-add', id='hotplug-mon',
+                    qom_type='monitor-qmp',
+                    chardev='hotplug-chr')
+        return sock
+
+    def _remove_monitor(self):
+        """Remove the monitor + chardev."""
+        self.vm.cmd('object-del', id='hotplug-mon')
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
+        A dynamically-added monitor sends object-del targeting
+        itself.  Verify the request is rejected, but the monitor
+        can still be deleted from outside its own context.
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
+        # Self-removal: the dynamic monitor raises error
+        resp = qmp.cmd_obj({'execute': 'object-del',
+                            'arguments': {'id': 'hotplug-mon'}})
+        self.assertIn('error', resp)
+
+        qmp.close()
+
+        resp = self.vm.cmd('object-del', id='hotplug-mon')
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
2.54.0


