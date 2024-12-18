Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65E8AE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNry3-00013p-L2; Wed, 18 Dec 2024 06:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxz-0000vh-Qs
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxt-0005zy-Af
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=icK9mZ+BTwutXpAcicRi0lYfEt7an4Ag3b0ftFSB2fE=;
 b=fCLQhPPcqKiDkXsOA/RwBuvqJvq/Tty3zn/RJR+AC4UsIXdpziKHfAZKspnTMaSjPIP0nP
 UC01RY+4eX61yaqtVYBIe5IjD6KkoRD5IpqqJ+kChYYLZvzB0qM7rnjiturFd7tjjJ+hkh
 pI6QPMD6ivdNXtsul865AOEBQdVnmV0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-uBRrxH4FM562Q-Uac020Dw-1; Wed,
 18 Dec 2024 06:11:37 -0500
X-MC-Unique: uBRrxH4FM562Q-Uac020Dw-1
X-Mimecast-MFC-AGG-ID: uBRrxH4FM562Q-Uac020Dw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52E1C195421D
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:11:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05F5819560AD; Wed, 18 Dec 2024 11:11:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 37/38] tests/functional: Convert the hotplug_cpu avocado test
Date: Wed, 18 Dec 2024 12:09:57 +0100
Message-ID: <20241218110958.226932-38-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Since we don't have ssh support in the functional test framework yet,
simply use the serial console for this test instead. It's also
sufficient to only boot into an initrd here, no need to fire up a
full-blown guest, so the test now finishes much faster.

While we're at it, also unplug the CPU now and check that it is gone
in the guest.

Message-ID: <20241217142020.155776-1-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/avocado/hotplug_cpu.py                | 37 -----------
 tests/functional/meson.build                |  1 +
 tests/functional/test_x86_64_hotplug_cpu.py | 69 +++++++++++++++++++++
 3 files changed, 70 insertions(+), 37 deletions(-)
 delete mode 100644 tests/avocado/hotplug_cpu.py
 create mode 100755 tests/functional/test_x86_64_hotplug_cpu.py

diff --git a/tests/avocado/hotplug_cpu.py b/tests/avocado/hotplug_cpu.py
deleted file mode 100644
index 342c838539..0000000000
--- a/tests/avocado/hotplug_cpu.py
+++ /dev/null
@@ -1,37 +0,0 @@
-# Functional test that hotplugs a CPU and checks it on a Linux guest
-#
-# Copyright (c) 2021 Red Hat, Inc.
-#
-# Author:
-#  Cleber Rosa <crosa@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-
-from avocado_qemu.linuxtest import LinuxTest
-
-
-class HotPlugCPU(LinuxTest):
-
-    def test(self):
-        """
-        :avocado: tags=arch:x86_64
-        :avocado: tags=machine:q35
-        :avocado: tags=accel:kvm
-        """
-        self.require_accelerator('kvm')
-        self.vm.add_args('-accel', 'kvm')
-        self.vm.add_args('-cpu', 'Haswell')
-        self.vm.add_args('-smp', '1,sockets=1,cores=2,threads=1,maxcpus=2')
-        self.launch_and_wait()
-
-        self.ssh_command('test -e /sys/devices/system/cpu/cpu0')
-        with self.assertRaises(AssertionError):
-            self.ssh_command('test -e /sys/devices/system/cpu/cpu1')
-
-        self.vm.cmd('device_add',
-                    driver='Haswell-x86_64-cpu',
-                    socket_id=0,
-                    core_id=1,
-                    thread_id=0)
-        self.ssh_command('test -e /sys/devices/system/cpu/cpu1')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index d03fe0ca36..24f7f8f2f1 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -233,6 +233,7 @@ tests_x86_64_system_thorough = [
   'multiprocess',
   'netdev_ethtool',
   'virtio_gpu',
+  'x86_64_hotplug_cpu',
   'x86_64_tuxrun',
 ]
 
diff --git a/tests/functional/test_x86_64_hotplug_cpu.py b/tests/functional/test_x86_64_hotplug_cpu.py
new file mode 100755
index 0000000000..b1d5156c72
--- /dev/null
+++ b/tests/functional/test_x86_64_hotplug_cpu.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python3
+#
+# Functional test that hotplugs a CPU and checks it on a Linux guest
+#
+# Copyright (c) 2021 Red Hat, Inc.
+#
+# Author:
+#  Cleber Rosa <crosa@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+
+
+class HotPlugCPU(LinuxKernelTest):
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
+    def test_hotplug(self):
+
+        self.require_accelerator('kvm')
+        self.vm.add_args('-accel', 'kvm')
+        self.vm.add_args('-cpu', 'Haswell')
+        self.vm.add_args('-smp', '1,sockets=1,cores=2,threads=1,maxcpus=2')
+        self.vm.add_args('-m', '1G')
+        self.vm.add_args('-append', 'console=ttyS0 rd.rescue')
+
+        self.launch_kernel(self.ASSET_KERNEL.fetch(),
+                           self.ASSET_INITRD.fetch(),
+                           wait_for='Entering emergency mode.')
+        prompt = '# '
+        self.wait_for_console_pattern(prompt)
+
+        exec_command_and_wait_for_pattern(self,
+                                          'cd /sys/devices/system/cpu/cpu0',
+                                          'cpu0#')
+        exec_command_and_wait_for_pattern(self,
+                                          'cd /sys/devices/system/cpu/cpu1',
+                                          'No such file or directory')
+
+        self.vm.cmd('device_add',
+                    driver='Haswell-x86_64-cpu',
+                    id='c1',
+                    socket_id=0,
+                    core_id=1,
+                    thread_id=0)
+        self.wait_for_console_pattern('CPU1 has been hot-added')
+
+        exec_command_and_wait_for_pattern(self,
+                                          'cd /sys/devices/system/cpu/cpu1',
+                                          'cpu1#')
+
+        self.vm.cmd('device_del', id='c1')
+
+        exec_command_and_wait_for_pattern(self,
+                                          'cd /sys/devices/system/cpu/cpu1',
+                                          'No such file or directory')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.1


