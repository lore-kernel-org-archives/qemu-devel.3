Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83354E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 11:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrxv-0000T4-Pc; Wed, 18 Dec 2024 06:11:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxs-0000D9-TB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNrxq-0005zV-DC
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 06:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734520296;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ujDHXVLHZ89hLzGpU0o7/zSt6K4GFm6yC1jQ+/whgv8=;
 b=JmvKbVgDKS5r3e5GJyhH1K9D37KprVT5+8FeXSMG0Sgmlokut+2Fuk9oDEjKwTbhShegtv
 hvC14r2xP6xolmhDkQfDGFKZT5BFLXZZJRzkYAKTk/amAFW+cUAweZE9WYpkTkJ/bTPYJ6
 ifBmJnsDc+GzSet+8nL1U1V+slPRchg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-bBr8CLw7PA2IASz6KYa8mw-1; Wed,
 18 Dec 2024 06:11:35 -0500
X-MC-Unique: bBr8CLw7PA2IASz6KYa8mw-1
X-Mimecast-MFC-AGG-ID: bBr8CLw7PA2IASz6KYa8mw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76F7B1955E8C
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 11:11:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.114])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F2BC919560AD; Wed, 18 Dec 2024 11:11:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 36/38] tests/functional: Convert the intel_iommu avocado test
Date: Wed, 18 Dec 2024 12:09:56 +0100
Message-ID: <20241218110958.226932-37-thuth@redhat.com>
In-Reply-To: <20241218110958.226932-1-thuth@redhat.com>
References: <20241218110958.226932-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

Convert the intel_iommu test to the new functional framework.
This test needs some changes since we neither support the old 'LinuxTest'
class in the functional framework yet, nor a way to use SSH for running
commands in the guest. So we now directly download a Fedora kernel and
initrd and set up the serial console for executing the commands and for
looking for the results. Instead of configuring the cloud image via
cloud-init, we now simply mount the file system manually from an initrd
rescue shell.

While the old test was exercising the network with a "dnf install"
command (which is not the best option for the CI since this depends
on third party servers), the new code is now setting up a little
HTTP server in the guest and transfers a file from the guest to the
host instead.

The test should now run much faster and more reliable (since we
don't depend on the third party servers for "dnf install" anymore),
so we can also drop the @skipUnless decorator now.

Message-ID: <20241217121550.141072-3-thuth@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                          |   1 +
 tests/avocado/intel_iommu.py         | 122 -------------------
 tests/functional/meson.build         |   4 +-
 tests/functional/test_intel_iommu.py | 175 +++++++++++++++++++++++++++
 4 files changed, 179 insertions(+), 123 deletions(-)
 delete mode 100644 tests/avocado/intel_iommu.py
 create mode 100755 tests/functional/test_intel_iommu.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e2f71e3b8..430a0f4f8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3682,6 +3682,7 @@ S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
 F: include/hw/i386/intel_iommu.h
+F: tests/functional/test_intel_iommu.py
 
 AMD-Vi Emulation
 S: Orphan
diff --git a/tests/avocado/intel_iommu.py b/tests/avocado/intel_iommu.py
deleted file mode 100644
index 992583fa7d..0000000000
--- a/tests/avocado/intel_iommu.py
+++ /dev/null
@@ -1,122 +0,0 @@
-# INTEL_IOMMU Functional tests
-#
-# Copyright (c) 2021 Red Hat, Inc.
-#
-# Author:
-#  Eric Auger <eric.auger@redhat.com>
-#
-# This work is licensed under the terms of the GNU GPL, version 2 or
-# later.  See the COPYING file in the top-level directory.
-import os
-
-from avocado import skipUnless
-from avocado_qemu.linuxtest import LinuxTest
-
-@skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-class IntelIOMMU(LinuxTest):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=distro:fedora
-    :avocado: tags=distro_version:31
-    :avocado: tags=machine:q35
-    :avocado: tags=accel:kvm
-    :avocado: tags=intel_iommu
-    :avocado: tags=flaky
-    """
-
-    IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
-    kernel_path = None
-    initrd_path = None
-    kernel_params = None
-
-    def set_up_boot(self):
-        path = self.download_boot()
-        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
-                         'drive=drv0,id=virtio-disk0,bootindex=1,'
-                         'werror=stop,rerror=stop' + self.IOMMU_ADDON)
-        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
-        self.vm.add_args('-drive',
-                         'file=%s,if=none,cache=writethrough,id=drv0' % path)
-
-    def setUp(self):
-        super(IntelIOMMU, self).setUp(None, 'virtio-net-pci' + self.IOMMU_ADDON)
-
-    def add_common_args(self):
-        self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
-        self.vm.add_args('-object',
-                         'rng-random,id=rng0,filename=/dev/urandom')
-
-    def common_vm_setup(self, custom_kernel=None):
-        self.require_accelerator("kvm")
-        self.add_common_args()
-        self.vm.add_args("-accel", "kvm")
-
-        if custom_kernel is None:
-            return
-
-        kernel_url = self.distro.pxeboot_url + 'vmlinuz'
-        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
-        initrd_url = self.distro.pxeboot_url + 'initrd.img'
-        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
-        self.kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
-
-    def run_and_check(self):
-        if self.kernel_path:
-            self.vm.add_args('-kernel', self.kernel_path,
-                             '-append', self.kernel_params,
-                             '-initrd', self.initrd_path)
-        self.launch_and_wait()
-        self.ssh_command('cat /proc/cmdline')
-        self.ssh_command('dmesg | grep -e DMAR -e IOMMU')
-        self.ssh_command('find /sys/kernel/iommu_groups/ -type l')
-        self.ssh_command('dnf -y install numactl-devel')
-
-    def test_intel_iommu(self):
-        """
-        :avocado: tags=intel_iommu_intremap
-        """
-
-        self.common_vm_setup(True)
-        self.vm.add_args('-device', 'intel-iommu,intremap=on')
-        self.vm.add_args('-machine', 'kernel_irqchip=split')
-
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' quiet intel_iommu=on')
-        self.run_and_check()
-
-    def test_intel_iommu_strict(self):
-        """
-        :avocado: tags=intel_iommu_strict
-        """
-
-        self.common_vm_setup(True)
-        self.vm.add_args('-device', 'intel-iommu,intremap=on')
-        self.vm.add_args('-machine', 'kernel_irqchip=split')
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' quiet intel_iommu=on,strict')
-        self.run_and_check()
-
-    def test_intel_iommu_strict_cm(self):
-        """
-        :avocado: tags=intel_iommu_strict_cm
-        """
-
-        self.common_vm_setup(True)
-        self.vm.add_args('-device', 'intel-iommu,intremap=on,caching-mode=on')
-        self.vm.add_args('-machine', 'kernel_irqchip=split')
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' quiet intel_iommu=on,strict')
-        self.run_and_check()
-
-    def test_intel_iommu_pt(self):
-        """
-        :avocado: tags=intel_iommu_pt
-        """
-
-        self.common_vm_setup(True)
-        self.vm.add_args('-device', 'intel-iommu,intremap=on')
-        self.vm.add_args('-machine', 'kernel_irqchip=split')
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' quiet intel_iommu=on iommu=pt')
-        self.run_and_check()
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ebb26d7044..d03fe0ca36 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -31,6 +31,7 @@ test_timeouts = {
   'arm_raspi2' : 120,
   'arm_tuxrun' : 240,
   'arm_sx1' : 360,
+  'intel_iommu': 300,
   'mips_malta' : 120,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
@@ -227,11 +228,12 @@ tests_x86_64_system_quick = [
 
 tests_x86_64_system_thorough = [
   'acpi_bits',
-  'x86_64_tuxrun',
+  'intel_iommu',
   'linux_initrd',
   'multiprocess',
   'netdev_ethtool',
   'virtio_gpu',
+  'x86_64_tuxrun',
 ]
 
 tests_xtensa_system_thorough = [
diff --git a/tests/functional/test_intel_iommu.py b/tests/functional/test_intel_iommu.py
new file mode 100755
index 0000000000..a9e8f82ab5
--- /dev/null
+++ b/tests/functional/test_intel_iommu.py
@@ -0,0 +1,175 @@
+#!/usr/bin/env python3
+#
+# INTEL_IOMMU Functional tests
+#
+# Copyright (c) 2021 Red Hat, Inc.
+#
+# Author:
+#  Eric Auger <eric.auger@redhat.com>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+import hashlib
+import urllib.request
+
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test.utils import get_usernet_hostfwd_port
+
+
+class IntelIOMMU(LinuxKernelTest):
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
+    ASSET_DISKIMAGE = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/releases'
+         '/31/Cloud/x86_64/images/Fedora-Cloud-Base-31-1.9.x86_64.qcow2'),
+        'e3c1b309d9203604922d6e255c2c5d098a309c2d46215d8fc026954f3c5c27a0')
+
+    DEFAULT_KERNEL_PARAMS = ('root=/dev/vda1 console=ttyS0 net.ifnames=0 '
+                             'quiet rd.rescue ')
+    GUEST_PORT = 8080
+    IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
+    kernel_path = None
+    initrd_path = None
+    kernel_params = None
+
+    def add_common_args(self, path):
+        self.vm.add_args('-drive', f'file={path},if=none,id=drv0,snapshot=on')
+        self.vm.add_args('-device', 'virtio-blk-pci,bus=pcie.0,' +
+                         'drive=drv0,id=virtio-disk0,bootindex=1,'
+                         'werror=stop,rerror=stop' + self.IOMMU_ADDON)
+        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
+
+        self.vm.add_args('-netdev',
+                         'user,id=n1,hostfwd=tcp:127.0.0.1:0-:%d' %
+                         self.GUEST_PORT)
+        self.vm.add_args('-device',
+                         'virtio-net-pci,netdev=n1' + self.IOMMU_ADDON)
+
+        self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
+        self.vm.add_args('-object',
+                         'rng-random,id=rng0,filename=/dev/urandom')
+        self.vm.add_args("-m", "1G")
+        self.vm.add_args("-accel", "kvm")
+
+    def common_vm_setup(self):
+        self.set_machine('q35')
+        self.require_accelerator("kvm")
+        self.require_netdev('user')
+
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.initrd_path = self.ASSET_INITRD.fetch()
+        image_path = self.ASSET_DISKIMAGE.fetch()
+        self.add_common_args(image_path)
+        self.kernel_params = self.DEFAULT_KERNEL_PARAMS
+
+    def run_and_check(self):
+        if self.kernel_path:
+            self.vm.add_args('-kernel', self.kernel_path,
+                             '-append', self.kernel_params,
+                             '-initrd', self.initrd_path)
+        self.vm.set_console()
+        self.vm.launch()
+        self.wait_for_console_pattern('Entering emergency mode.')
+        prompt = '# '
+        self.wait_for_console_pattern(prompt)
+
+        # Copy a file (checked later), umount afterwards to drop disk cache:
+        exec_command_and_wait_for_pattern(self, 'mount /dev/vda1 /sysroot',
+                                          prompt)
+        filename = '/boot/initramfs-5.3.7-301.fc31.x86_64.img'
+        exec_command_and_wait_for_pattern(self, (f'cp /sysroot{filename}'
+                                                 ' /sysroot/root/data'),
+                                          prompt)
+        exec_command_and_wait_for_pattern(self, 'umount /sysroot', prompt)
+
+        # Switch from initrd to the cloud image filesystem:
+        exec_command_and_wait_for_pattern(self, 'mount /dev/vda1 /sysroot',
+                                          prompt)
+        exec_command_and_wait_for_pattern(self,
+                ('for d in dev proc sys run ; do '
+                 'mount -o bind /$d /sysroot/$d ; done'), prompt)
+        exec_command_and_wait_for_pattern(self, 'chroot /sysroot', prompt)
+
+        # Checking for IOMMU enablement:
+        self.log.info("Checking whether IOMMU has been enabled...")
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cmdline',
+                                          'intel_iommu=on')
+        self.wait_for_console_pattern(prompt)
+        exec_command_and_wait_for_pattern(self, 'dmesg | grep DMAR:',
+                                          'IOMMU enabled')
+        self.wait_for_console_pattern(prompt)
+        exec_command_and_wait_for_pattern(self,
+                                    'find /sys/kernel/iommu_groups/ -type l',
+                                    'devices/0000:00:')
+        self.wait_for_console_pattern(prompt)
+
+        # Check hard disk device via sha256sum:
+        self.log.info("Checking hard disk...")
+        hashsum = '0dc7472f879be70b2f3daae279e3ae47175ffe249691e7d97f47222b65b8a720'
+        exec_command_and_wait_for_pattern(self, 'sha256sum ' + filename,
+                                          hashsum)
+        self.wait_for_console_pattern(prompt)
+        exec_command_and_wait_for_pattern(self, 'sha256sum /root/data',
+                                          hashsum)
+        self.wait_for_console_pattern(prompt)
+
+        # Check virtio-net via HTTP:
+        exec_command_and_wait_for_pattern(self, 'dhclient eth0', prompt)
+        exec_command_and_wait_for_pattern(self,
+                        f'python3 -m http.server {self.GUEST_PORT} & sleep 1',
+                        f'Serving HTTP on 0.0.0.0 port {self.GUEST_PORT}')
+        hl = hashlib.sha256()
+        hostport = get_usernet_hostfwd_port(self.vm)
+        url = f'http://localhost:{hostport}{filename}'
+        self.log.info(f'Downloading {url} ...')
+        with urllib.request.urlopen(url) as response:
+            while True:
+                chunk = response.read(1 << 20)
+                if not chunk:
+                    break
+                hl.update(chunk)
+
+        digest = hl.hexdigest()
+        self.log.info(f'sha256sum of download is {digest}.')
+        self.assertEqual(digest, hashsum)
+
+    def test_intel_iommu(self):
+        self.common_vm_setup()
+        self.vm.add_args('-device', 'intel-iommu,intremap=on')
+        self.vm.add_args('-machine', 'kernel_irqchip=split')
+        self.kernel_params += 'intel_iommu=on'
+        self.run_and_check()
+
+    def test_intel_iommu_strict(self):
+        self.common_vm_setup()
+        self.vm.add_args('-device', 'intel-iommu,intremap=on')
+        self.vm.add_args('-machine', 'kernel_irqchip=split')
+        self.kernel_params += 'intel_iommu=on,strict'
+        self.run_and_check()
+
+    def test_intel_iommu_strict_cm(self):
+        self.common_vm_setup()
+        self.vm.add_args('-device', 'intel-iommu,intremap=on,caching-mode=on')
+        self.vm.add_args('-machine', 'kernel_irqchip=split')
+        self.kernel_params += 'intel_iommu=on,strict'
+        self.run_and_check()
+
+    def test_intel_iommu_pt(self):
+        self.common_vm_setup()
+        self.vm.add_args('-device', 'intel-iommu,intremap=on')
+        self.vm.add_args('-machine', 'kernel_irqchip=split')
+        self.kernel_params += 'intel_iommu=on iommu=pt'
+        self.run_and_check()
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.1


