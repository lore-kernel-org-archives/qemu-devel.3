Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89AFC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgz9H-0003hY-Kp; Tue, 07 Jul 2026 02:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wgz9B-0003es-Mz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:19:11 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@posteo.eu>) id 1wgz99-0001H7-G4
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:19:09 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 44F49240103
 for <qemu-devel@nongnu.org>; Tue,  7 Jul 2026 08:19:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu;
 s=1984.8680eb; t=1783405144;
 bh=VKFM2IaRNN4DJdtb2GSgcTdTHhiZmoE3vAhb4sDdm2U=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=SVjsD+99X1DWbB3N9Oj3Cw5u2lyYhScTMSdh/wJiccLGJAjEM9XOH4wEugd0pzoq6
 vgWaN5lSPCpLOyW/0Fi14tW+oI41FxQrrzcaqtl1rcgkhFHN+qhkSKyD9obXlIXuAD
 QNxU7LoYv34d2g36lRDGLGsWvRe9Hz6StZJ5eDDtR6xGN+yrSaZLYahg7ox+U31S6j
 ykRHJMiJBHTHSXwwK6e2PW2kxiq6PPNgl81kgeTrcaAkl7fSCKCyNuYwNby0ZkdsMq
 Fze0gHE9gn4buyW/OyKRkcsOHBzv7FWDWfgrf/FoTI0pTPrZo+6ejp8cY4epYycMKG
 9wiXjtsMDaVWQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gvWJl6B1Vz9rxG;
 Tue,  7 Jul 2026 08:19:03 +0200 (CEST)
From: Thomas Huth <th.huth@posteo.eu>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: [PULL 1/3] tests/functional: Add hotplug_scsi test to hotplug
 virtio-scsi disk
Date: Tue, 07 Jul 2026 06:19:04 +0000
Message-ID: <20260707061851.8298-2-th.huth@posteo.eu>
In-Reply-To: <20260707061851.8298-1-th.huth@posteo.eu>
References: <20260707061851.8298-1-th.huth@posteo.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66; envelope-from=th.huth@posteo.eu;
 helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Siddhi Katage <siddhi.katage@oracle.com>

Signed-off-by: Siddhi Katage <siddhi.katage@oracle.com>
Message-ID: <20260210113135.771697-1-siddhi.katage@oracle.com>
[thuth: Add the new .py file to the MAINTAINERS file]
Signed-off-by: Thomas Huth <th.huth@posteo.eu>
---
 MAINTAINERS                                  |  1 +
 tests/functional/x86_64/meson.build          |  1 +
 tests/functional/x86_64/test_hotplug_scsi.py | 86 ++++++++++++++++++++
 3 files changed, 88 insertions(+)
 create mode 100755 tests/functional/x86_64/test_hotplug_scsi.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 97dcc78ded..ed65654698 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2338,6 +2338,7 @@ F: tests/qtest/virtio-scsi-test.c
 F: tests/qtest/fuzz-virtio-scsi-test.c
 F: tests/qtest/am53c974-test.c
 F: tests/qtest/fuzz-lsi53c895a-test.c
+F: tests/functional/x86_64/test_hotplug_scsi.py
 T: git https://github.com/bonzini/qemu.git scsi-next
 
 SSI
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
index 1ed10ad6c2..d237ca156e 100644
--- a/tests/functional/x86_64/meson.build
+++ b/tests/functional/x86_64/meson.build
@@ -31,6 +31,7 @@ endif
 tests_x86_64_system_thorough = [
   'acpi_bits',
   'hotplug_blk',
+  'hotplug_scsi',
   'hotplug_cpu',
   'intel_iommu',
   'kvm_xen',
diff --git a/tests/functional/x86_64/test_hotplug_scsi.py b/tests/functional/x86_64/test_hotplug_scsi.py
new file mode 100755
index 0000000000..10fd306616
--- /dev/null
+++ b/tests/functional/x86_64/test_hotplug_scsi.py
@@ -0,0 +1,86 @@
+#!/usr/bin/env python3
+#
+# Functional test that hotplugs a virtio scsi disk and checks it on a Linux
+# guest
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+
+class HotPlugScsi(LinuxKernelTest):
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
+            'node-name': 'disk0'
+        })
+
+    def add_scsi_controller(self) -> None:
+        self.vm.cmd('device_add', {
+            'driver': 'virtio-scsi-pci',
+            'id': 'scsi0',
+            'bus': 'pci.1',
+            'addr': '1',
+        })
+
+    def assert_sda(self) -> None:
+        exec_command_and_wait_for_pattern(self, 'while ! test -e /sys/block/sda ;'
+                                                ' do sleep 0.2 ; done', '# ')
+
+    def assert_no_sda(self) -> None:
+        exec_command_and_wait_for_pattern(self, 'while test -e /sys/block/sda ;'
+                                                ' do sleep 0.2 ; done', '# ')
+
+    def plug(self) -> None:
+        args = {
+            'driver':'scsi-hd',
+            'drive':'disk0',
+            'bus':'scsi0.0',
+            'id':'scsi-disk0',
+        }
+
+        self.assert_no_sda()
+        self.vm.cmd('device_add', args)
+        self.wait_for_console_pattern('[sda] Attached SCSI disk')
+        self.assert_sda()
+
+    def unplug(self) -> None:
+        self.vm.cmd('device_del', id='scsi-disk0')
+
+        self.vm.event_wait('DEVICE_DELETED', 1.0,
+                           match={'data': {'device': 'scsi-disk0'}})
+
+        self.assert_no_sda()
+
+    def test(self) -> None:
+        self.require_accelerator('kvm')
+        self.set_machine('q35')
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
+        self.add_scsi_controller()
+        self.plug()
+        self.unplug()
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
+
-- 
2.54.0


