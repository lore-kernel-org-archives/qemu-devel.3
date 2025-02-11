Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB84C0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 12:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thpQs-0005gp-64; Tue, 11 Feb 2025 07:32:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQo-0005f3-7S
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:32:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1thpQl-0000Ih-Ve
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 07:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739277118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yySPF2XVc59xk72H2CqL2RUBBUeR8dICsJbRFcZGRGs=;
 b=eLpbzjsjdXEApOLho6p+BmLbodUgrkFinHJVS4ERat2hnDwfcpWTspn8Rc+oAO+78R04If
 iNN1ohApV0iM2A7vfO089T4LlQyN/u7lEvwOgI2GUSy3BVvcmVl7Q6AZg9C6LggQ+Djr+X
 PrBoSs7VDfhIA/anJrNQw9ijlhGR8Ac=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-5QLXKC9iO3CuLAt5gXS6fw-1; Tue,
 11 Feb 2025 07:31:56 -0500
X-MC-Unique: 5QLXKC9iO3CuLAt5gXS6fw-1
X-Mimecast-MFC-AGG-ID: 5QLXKC9iO3CuLAt5gXS6fw_1739277116
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10B921800874
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 12:31:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.52])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9CDE19560A3; Tue, 11 Feb 2025 12:31:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 3/7] tests/functional: Convert the hotplug_blk avocado test
Date: Tue, 11 Feb 2025 13:31:40 +0100
Message-ID: <20250211123144.37617-4-thuth@redhat.com>
In-Reply-To: <20250211123144.37617-1-thuth@redhat.com>
References: <20250211123144.37617-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

By using the serial console instead of ssh for executing commands
in the guest, we can convert this test to the functional framework.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20250130192712.19542-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                 |  1 +
 tests/avocado/hotplug_blk.py                | 69 -----------------
 tests/functional/meson.build                |  1 +
 tests/functional/test_x86_64_hotplug_blk.py | 85 +++++++++++++++++++++
 4 files changed, 87 insertions(+), 69 deletions(-)
 delete mode 100644 tests/avocado/hotplug_blk.py
 create mode 100755 tests/functional/test_x86_64_hotplug_blk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index ebb415bc40..a593241800 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2275,6 +2275,7 @@ F: hw/block/virtio-blk.c
 F: hw/block/dataplane/*
 F: include/hw/virtio/virtio-blk-common.h
 F: tests/qtest/virtio-blk-test.c
+F: tests/functional/test_x86_64_hotplug_blk.py
 T: git https://github.com/stefanha/qemu.git block
 
 virtio-ccw
diff --git a/tests/avocado/hotplug_blk.py b/tests/avocado/hotplug_blk.py
deleted file mode 100644
index b36bca02ec..0000000000
--- a/tests/avocado/hotplug_blk.py
+++ /dev/null
@@ -1,69 +0,0 @@
-# Functional test that hotplugs a virtio blk disk and checks it on a Linux
-# guest
-#
-# Copyright (c) 2021 Red Hat, Inc.
-# Copyright (c) Yandex
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-import time
-
-from avocado_qemu.linuxtest import LinuxTest
-
-
-class HotPlug(LinuxTest):
-    def blockdev_add(self) -> None:
-        self.vm.cmd('blockdev-add', **{
-            'driver': 'null-co',
-            'size': 1073741824,
-            'node-name': 'disk'
-        })
-
-    def assert_vda(self) -> None:
-        self.ssh_command('test -e /sys/block/vda')
-
-    def assert_no_vda(self) -> None:
-        with self.assertRaises(AssertionError):
-            self.assert_vda()
-
-    def plug(self) -> None:
-        args = {
-            'driver': 'virtio-blk-pci',
-            'drive': 'disk',
-            'id': 'virtio-disk0',
-            'bus': 'pci.1',
-            'addr': '1',
-        }
-
-        self.assert_no_vda()
-        self.vm.cmd('device_add', args)
-        try:
-            self.assert_vda()
-        except AssertionError:
-            time.sleep(1)
-            self.assert_vda()
-
-    def unplug(self) -> None:
-        self.vm.cmd('device_del', id='virtio-disk0')
-
-        self.vm.event_wait('DEVICE_DELETED', 1.0,
-                           match={'data': {'device': 'virtio-disk0'}})
-
-        self.assert_no_vda()
-
-    def test(self) -> None:
-        """
-        :avocado: tags=arch:x86_64
-        :avocado: tags=machine:q35
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator('kvm')
-        self.vm.add_args('-accel', 'kvm')
-        self.vm.add_args('-device', 'pcie-pci-bridge,id=pci.1,bus=pcie.0')
-
-        self.launch_and_wait()
-        self.blockdev_add()
-
-        self.plug()
-        self.unplug()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e595508bfa..70646d3457 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -285,6 +285,7 @@ tests_x86_64_system_thorough = [
   'multiprocess',
   'netdev_ethtool',
   'virtio_gpu',
+  'x86_64_hotplug_blk',
   'x86_64_hotplug_cpu',
   'x86_64_kvm_xen',
   'x86_64_tuxrun',
diff --git a/tests/functional/test_x86_64_hotplug_blk.py b/tests/functional/test_x86_64_hotplug_blk.py
new file mode 100755
index 0000000000..7ddbfefc21
--- /dev/null
+++ b/tests/functional/test_x86_64_hotplug_blk.py
@@ -0,0 +1,85 @@
+#!/usr/bin/env python3
+#
+# Functional test that hotplugs a virtio blk disk and checks it on a Linux
+# guest
+#
+# Copyright (c) 2021 Red Hat, Inc.
+# Copyright (c) Yandex
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+
+
+class HotPlugBlk(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/vmlinuz'),
+        'd4738d03dbbe083ca610d0821d0a8f1488bebbdccef54ce33e3adb35fda00129')
+
+    ASSET_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Server/x86_64/os/images/pxeboot/initrd.img'),
+        '277cd6c7adf77c7e63d73bbb2cded8ef9e2d3a2f100000e92ff1f8396513cd8b')
+
+    def blockdev_add(self) -> None:
+        self.vm.cmd('blockdev-add', **{
+            'driver': 'null-co',
+            'size': 1073741824,
+            'node-name': 'disk'
+        })
+
+    def assert_vda(self) -> None:
+        exec_command_and_wait_for_pattern(self, 'while ! test -e /sys/block/vda ;'
+                                                ' do sleep 0.2 ; done', '# ')
+
+    def assert_no_vda(self) -> None:
+        exec_command_and_wait_for_pattern(self, 'while test -e /sys/block/vda ;'
+                                                ' do sleep 0.2 ; done', '# ')
+
+    def plug(self) -> None:
+        args = {
+            'driver': 'virtio-blk-pci',
+            'drive': 'disk',
+            'id': 'virtio-disk0',
+            'bus': 'pci.1',
+            'addr': '1',
+        }
+
+        self.assert_no_vda()
+        self.vm.cmd('device_add', args)
+        self.wait_for_console_pattern('virtio_blk virtio0: [vda]')
+        self.assert_vda()
+
+    def unplug(self) -> None:
+        self.vm.cmd('device_del', id='virtio-disk0')
+
+        self.vm.event_wait('DEVICE_DELETED', 1.0,
+                           match={'data': {'device': 'virtio-disk0'}})
+
+        self.assert_no_vda()
+
+    def test(self) -> None:
+        self.require_accelerator('kvm')
+        self.set_machine('q35')
+
+        self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args('-device', 'pcie-pci-bridge,id=pci.1,bus=pcie.0')
+        self.vm.add_args('-m', '1G')
+        self.vm.add_args('-append', 'console=ttyS0 rd.rescue')
+
+        self.launch_kernel(self.ASSET_KERNEL.fetch(),
+                           self.ASSET_INITRD.fetch(),
+                           wait_for='Entering emergency mode.')
+        self.wait_for_console_pattern('# ')
+
+        self.blockdev_add()
+
+        self.plug()
+        self.unplug()
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.48.1


