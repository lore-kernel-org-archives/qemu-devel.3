Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CBBDE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJctw-0006sM-Ul; Fri, 06 Dec 2024 13:18:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJcto-0006iJ-1A
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:17:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tJctf-0005xV-GF
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733509061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=c4uFeZSoR59ahaJfkFIGos/Z3D4DZaECEsQT1YrRS3g=;
 b=VwIOYqEKKOBRF0U9uIReWyGoBz2ZpIpW7NgzRMozCkqndyOb2eHqwB0i35zSBlosHvMhmT
 bHsD3V8kIl4SKfTyVEsn8bmNlCf3RlJsPCJa3j0bQsDXOODZcYV8GApghaUW5CCoFk9mYI
 tCNS3DnA2ie2AYf9C2gc2Ky+sVFOphY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-1zGNmUFMPhGq8C6IAdeyhw-1; Fri,
 06 Dec 2024 13:17:38 -0500
X-MC-Unique: 1zGNmUFMPhGq8C6IAdeyhw-1
X-Mimecast-MFC-AGG-ID: 1zGNmUFMPhGq8C6IAdeyhw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 60F6E1955DE3; Fri,  6 Dec 2024 18:17:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.66])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C9704300019E; Fri,  6 Dec 2024 18:17:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 Yi Liu <yi.l.liu@intel.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH for-10.0] tests/functional: Convert the intel_iommu avocado
 test
Date: Fri,  6 Dec 2024 19:17:28 +0100
Message-ID: <20241206181728.1241169-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
looking for the results.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |   1 +
 tests/functional/meson.build                  |   1 +
 .../test_intel_iommu.py}                      | 119 ++++++++----------
 3 files changed, 51 insertions(+), 70 deletions(-)
 rename tests/{avocado/intel_iommu.py => functional/test_intel_iommu.py} (41%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index a62659b330..2ca452dbf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3679,6 +3679,7 @@ S: Supported
 F: hw/i386/intel_iommu.c
 F: hw/i386/intel_iommu_internal.h
 F: include/hw/i386/intel_iommu.h
+F: tests/functional/test_intel_iommu.py
 
 AMD-Vi Emulation
 S: Orphan
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 30c3eda7e4..dfc95fd904 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -238,6 +238,7 @@ tests_x86_64_system_quick = [
 
 tests_x86_64_system_thorough = [
   'acpi_bits',
+  'intel_iommu',
   'x86_64_tuxrun',
   'linux_initrd',
   'multiprocess',
diff --git a/tests/avocado/intel_iommu.py b/tests/functional/test_intel_iommu.py
old mode 100644
new mode 100755
similarity index 41%
rename from tests/avocado/intel_iommu.py
rename to tests/functional/test_intel_iommu.py
index 992583fa7d..6e47b1e9de
--- a/tests/avocado/intel_iommu.py
+++ b/tests/functional/test_intel_iommu.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # INTEL_IOMMU Functional tests
 #
 # Copyright (c) 2021 Red Hat, Inc.
@@ -7,116 +9,93 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
-import os
 
-from avocado import skipUnless
-from avocado_qemu.linuxtest import LinuxTest
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+
+class IntelIOMMU(LinuxKernelTest):
 
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
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/39/Server/x86_64/os/images/pxeboot/vmlinuz'),
+        '5f2ef0de47f8d79d5ee9bf8b0ee6d5ba4d987c2f9a16b8b511a7c69e53931fe3')
+
+    ASSET_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora/linux/'
+         'releases/39/Server/x86_64/os/images/pxeboot/initrd.img'),
+        '5bc29e2d872ceeb39a9698d42da3fb0afd7583dc7180de05a6b78bcc726674bb')
 
     IOMMU_ADDON = ',iommu_platform=on,disable-modern=off,disable-legacy=on'
+    default_kernel_params = 'console=ttyS0 rd.rescue quiet '
     kernel_path = None
     initrd_path = None
     kernel_params = None
 
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
     def add_common_args(self):
         self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
         self.vm.add_args('-object',
                          'rng-random,id=rng0,filename=/dev/urandom')
+        self.vm.add_args('-device', 'virtio-net-pci' + self.IOMMU_ADDON)
+        self.vm.add_args('-device', 'virtio-gpu-pci' + self.IOMMU_ADDON)
+        self.vm.add_args("-m", "1G")
 
-    def common_vm_setup(self, custom_kernel=None):
+    def common_vm_setup(self):
+        self.set_machine('q35')
         self.require_accelerator("kvm")
         self.add_common_args()
         self.vm.add_args("-accel", "kvm")
 
-        if custom_kernel is None:
-            return
-
-        kernel_url = self.distro.pxeboot_url + 'vmlinuz'
-        kernel_hash = '5b6f6876e1b5bda314f93893271da0d5777b1f3c'
-        initrd_url = self.distro.pxeboot_url + 'initrd.img'
-        initrd_hash = 'dd0340a1b39bd28f88532babd4581c67649ec5b1'
-        self.kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-        self.initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.initrd_path = self.ASSET_INITRD.fetch()
+        self.kernel_params = self.default_kernel_params
 
     def run_and_check(self):
         if self.kernel_path:
             self.vm.add_args('-kernel', self.kernel_path,
                              '-append', self.kernel_params,
                              '-initrd', self.initrd_path)
-        self.launch_and_wait()
-        self.ssh_command('cat /proc/cmdline')
-        self.ssh_command('dmesg | grep -e DMAR -e IOMMU')
-        self.ssh_command('find /sys/kernel/iommu_groups/ -type l')
-        self.ssh_command('dnf -y install numactl-devel')
+        self.vm.set_console()
+        self.vm.launch()
+        self.wait_for_console_pattern('(or press Control-D to continue):')
+        prompt = ':/root#'
+        exec_command_and_wait_for_pattern(self, '', prompt)
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
 
     def test_intel_iommu(self):
-        """
-        :avocado: tags=intel_iommu_intremap
-        """
-
-        self.common_vm_setup(True)
+        self.common_vm_setup()
         self.vm.add_args('-device', 'intel-iommu,intremap=on')
         self.vm.add_args('-machine', 'kernel_irqchip=split')
-
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' quiet intel_iommu=on')
+        self.kernel_params += 'intel_iommu=on'
         self.run_and_check()
 
     def test_intel_iommu_strict(self):
-        """
-        :avocado: tags=intel_iommu_strict
-        """
-
-        self.common_vm_setup(True)
+        self.common_vm_setup()
         self.vm.add_args('-device', 'intel-iommu,intremap=on')
         self.vm.add_args('-machine', 'kernel_irqchip=split')
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' quiet intel_iommu=on,strict')
+        self.kernel_params += 'intel_iommu=on,strict'
         self.run_and_check()
 
     def test_intel_iommu_strict_cm(self):
-        """
-        :avocado: tags=intel_iommu_strict_cm
-        """
-
-        self.common_vm_setup(True)
+        self.common_vm_setup()
         self.vm.add_args('-device', 'intel-iommu,intremap=on,caching-mode=on')
         self.vm.add_args('-machine', 'kernel_irqchip=split')
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' quiet intel_iommu=on,strict')
+        self.kernel_params += 'intel_iommu=on,strict'
         self.run_and_check()
 
     def test_intel_iommu_pt(self):
-        """
-        :avocado: tags=intel_iommu_pt
-        """
-
-        self.common_vm_setup(True)
+        self.common_vm_setup()
         self.vm.add_args('-device', 'intel-iommu,intremap=on')
         self.vm.add_args('-machine', 'kernel_irqchip=split')
-        self.kernel_params = (self.distro.default_kernel_params +
-                              ' quiet intel_iommu=on iommu=pt')
+        self.kernel_params += 'intel_iommu=on iommu=pt'
         self.run_and_check()
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.1


