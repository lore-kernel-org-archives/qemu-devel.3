Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73AEBC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 08:03:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taVgb-0006nl-RK; Wed, 22 Jan 2025 03:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taVgZ-0006nU-PW
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:02:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1taVgX-0004uu-Ll
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 03:02:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737532921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4O/4/WIa7B6lNUnZqppcqVButjrXOQoZJiap9Ak6YSI=;
 b=ghdRxAWerh4JjsikC5PrrOZYx+ONKnCqb09myabusxV8Xgy0yW15daMMacAu311JnIBo8O
 EdPt2D3AnCrpRsXRnONoKnSqL91sLY/pFfQOaDr7z6WrQFqsnmbtoms8WD7Fl48J2iaHwu
 SsuLMYGMu/Ypzu7tgUQ4ZInBWZEhJiU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-iRMs0l7fOduzJX5OJQOReQ-1; Wed,
 22 Jan 2025 03:01:58 -0500
X-MC-Unique: iRMs0l7fOduzJX5OJQOReQ-1
X-Mimecast-MFC-AGG-ID: iRMs0l7fOduzJX5OJQOReQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDE2E195608D; Wed, 22 Jan 2025 08:01:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.246])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4F3DE19560A7; Wed, 22 Jan 2025 08:01:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PULL v2 1/9] tests/functional: Convert the kvm_xen_guest avocado test
Date: Wed, 22 Jan 2025 09:01:50 +0100
Message-ID: <20250122080151.1400422-2-thuth@redhat.com>
In-Reply-To: <20250122080151.1400422-1-thuth@redhat.com>
References: <20250122080151.1400422-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Use the serial console to execute the commands in the guest instead
of using ssh since we don't have ssh support in the functional
framework yet.

Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Message-ID: <20250113082516.57894-1-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  2 +
 .../test_x86_64_kvm_xen.py}                   | 89 +++++++++++--------
 3 files changed, 55 insertions(+), 38 deletions(-)
 rename tests/{avocado/kvm_xen_guest.py => functional/test_x86_64_kvm_xen.py} (61%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 846b81e3ec..94834b7876 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -489,7 +489,7 @@ S: Supported
 F: include/system/kvm_xen.h
 F: target/i386/kvm/xen*
 F: hw/i386/kvm/xen*
-F: tests/avocado/kvm_xen_guest.py
+F: tests/functional/test_x86_64_kvm_xen.py
 
 Guest CPU Cores (other accelerators)
 ------------------------------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index cf80924ddc..b7719ab85f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -44,6 +44,7 @@ test_timeouts = {
   'riscv64_tuxrun' : 120,
   's390x_ccw_virtio' : 420,
   'sh4_tuxrun' : 240,
+  'x86_64_kvm_xen' : 180,
 }
 
 tests_generic_system = [
@@ -244,6 +245,7 @@ tests_x86_64_system_thorough = [
   'netdev_ethtool',
   'virtio_gpu',
   'x86_64_hotplug_cpu',
+  'x86_64_kvm_xen',
   'x86_64_tuxrun',
 ]
 
diff --git a/tests/avocado/kvm_xen_guest.py b/tests/functional/test_x86_64_kvm_xen.py
old mode 100644
new mode 100755
similarity index 61%
rename from tests/avocado/kvm_xen_guest.py
rename to tests/functional/test_x86_64_kvm_xen.py
index f8cb458d5d..0298c96c2e
--- a/tests/avocado/kvm_xen_guest.py
+++ b/tests/functional/test_x86_64_kvm_xen.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # KVM Xen guest functional tests
 #
 # Copyright © 2021 Red Hat, Inc.
@@ -13,19 +15,12 @@
 
 from qemu.machine import machine
 
-from avocado_qemu import LinuxSSHMixIn
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
 
-class KVMXenGuest(QemuSystemTest, LinuxSSHMixIn):
-    """
-    :avocado: tags=arch:x86_64
-    :avocado: tags=machine:q35
-    :avocado: tags=accel:kvm
-    :avocado: tags=kvm_xen_guest
-    """
+class KVMXenGuest(QemuSystemTest):
 
-    KERNEL_DEFAULT = 'printk.time=0 root=/dev/xvda console=ttyS0'
+    KERNEL_DEFAULT = 'printk.time=0 root=/dev/xvda console=ttyS0 quiet'
 
     kernel_path = None
     kernel_params = None
@@ -33,14 +28,15 @@ class KVMXenGuest(QemuSystemTest, LinuxSSHMixIn):
     # Fetch assets from the kvm-xen-guest subdir of my shared test
     # images directory on fileserver.linaro.org where you can find
     # build instructions for how they where assembled.
-    def get_asset(self, name, sha1):
-        base_url = ('https://fileserver.linaro.org/s/'
-                    'kE4nCFLdQcoBF9t/download?'
-                    'path=%2Fkvm-xen-guest&files=' )
-        url = base_url + name
-        # use explicit name rather than failing to neatly parse the
-        # URL into a unique one
-        return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
+    ASSET_KERNEL = Asset(
+        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
+         'path=%2Fkvm-xen-guest&files=bzImage'),
+        'ec0ad7bb8c33c5982baee0a75505fe7dbf29d3ff5d44258204d6307c6fe0132a')
+
+    ASSET_ROOTFS = Asset(
+        ('https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?'
+         'path=%2Fkvm-xen-guest&files=rootfs.ext4'),
+        'b11045d649006c649c184e93339aaa41a8fe20a1a86620af70323252eb29e40b')
 
     def common_vm_setup(self):
         # We also catch lack of KVM_XEN support if we fail to launch
@@ -51,10 +47,8 @@ def common_vm_setup(self):
         self.vm.add_args("-accel", "kvm,xen-version=0x4000a,kernel-irqchip=split")
         self.vm.add_args("-smp", "2")
 
-        self.kernel_path = self.get_asset("bzImage",
-                                          "367962983d0d32109998a70b45dcee4672d0b045")
-        self.rootfs = self.get_asset("rootfs.ext4",
-                                     "f1478401ea4b3fa2ea196396be44315bab2bb5e4")
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.rootfs = self.ASSET_ROOTFS.fetch()
 
     def run_and_check(self):
         self.vm.add_args('-kernel', self.kernel_path,
@@ -68,10 +62,10 @@ def run_and_check(self):
             self.vm.launch()
         except machine.VMLaunchFailure as e:
             if "Xen HVM guest support not present" in e.output:
-                self.cancel("KVM Xen support is not present "
-                            "(need v5.12+ kernel with CONFIG_KVM_XEN)")
+                self.skipTest("KVM Xen support is not present "
+                              "(need v5.12+ kernel with CONFIG_KVM_XEN)")
             elif "Property 'kvm-accel.xen-version' not found" in e.output:
-                self.cancel("QEMU not built with CONFIG_XEN_EMU support")
+                self.skipTest("QEMU not built with CONFIG_XEN_EMU support")
             else:
                 raise e
 
@@ -79,10 +73,11 @@ def run_and_check(self):
         console_pattern = 'Starting dropbear sshd: OK'
         wait_for_console_pattern(self, console_pattern, 'Oops')
         self.log.info('sshd ready')
-        self.ssh_connect('root', '', False)
 
-        self.ssh_command('cat /proc/cmdline')
-        self.ssh_command('dmesg | grep -e "Grant table initialized"')
+        exec_command_and_wait_for_pattern(self, 'cat /proc/cmdline', 'xen')
+        exec_command_and_wait_for_pattern(self, 'dmesg | grep "Grant table"',
+                                          'Grant table initialized')
+        wait_for_console_pattern(self, '#', 'Oops')
 
     def test_kvm_xen_guest(self):
         """
@@ -94,7 +89,9 @@ def test_kvm_xen_guest(self):
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks')
         self.run_and_check()
-        self.ssh_command('grep xen-pirq.*msi /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-pirq.*msi /proc/interrupts',
+                                'virtio0-output')
 
     def test_kvm_xen_guest_nomsi(self):
         """
@@ -106,7 +103,9 @@ def test_kvm_xen_guest_nomsi(self):
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks pci=nomsi')
         self.run_and_check()
-        self.ssh_command('grep xen-pirq.* /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-pirq.* /proc/interrupts',
+                                'virtio0')
 
     def test_kvm_xen_guest_noapic_nomsi(self):
         """
@@ -118,7 +117,9 @@ def test_kvm_xen_guest_noapic_nomsi(self):
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks noapic pci=nomsi')
         self.run_and_check()
-        self.ssh_command('grep xen-pirq /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-pirq /proc/interrupts',
+                                'virtio0')
 
     def test_kvm_xen_guest_vapic(self):
         """
@@ -130,8 +131,13 @@ def test_kvm_xen_guest_vapic(self):
         self.kernel_params = (self.KERNEL_DEFAULT +
                               ' xen_emul_unplug=ide-disks')
         self.run_and_check()
-        self.ssh_command('grep xen-pirq /proc/interrupts')
-        self.ssh_command('grep PCI-MSI /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-pirq /proc/interrupts',
+                                'acpi')
+        wait_for_console_pattern(self, '#')
+        exec_command_and_wait_for_pattern(self,
+                                'grep PCI-MSI /proc/interrupts',
+                                'virtio0-output')
 
     def test_kvm_xen_guest_novector(self):
         """
@@ -143,7 +149,9 @@ def test_kvm_xen_guest_novector(self):
                               ' xen_emul_unplug=ide-disks' +
                               ' xen_no_vector_callback')
         self.run_and_check()
-        self.ssh_command('grep xen-platform-pci /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-platform-pci /proc/interrupts',
+                                'fasteoi')
 
     def test_kvm_xen_guest_novector_nomsi(self):
         """
@@ -156,7 +164,9 @@ def test_kvm_xen_guest_novector_nomsi(self):
                               ' xen_emul_unplug=ide-disks pci=nomsi' +
                               ' xen_no_vector_callback')
         self.run_and_check()
-        self.ssh_command('grep xen-platform-pci /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-platform-pci /proc/interrupts',
+                                'IO-APIC')
 
     def test_kvm_xen_guest_novector_noapic(self):
         """
@@ -168,4 +178,9 @@ def test_kvm_xen_guest_novector_noapic(self):
                               ' xen_emul_unplug=ide-disks' +
                               ' xen_no_vector_callback noapic')
         self.run_and_check()
-        self.ssh_command('grep xen-platform-pci /proc/interrupts')
+        exec_command_and_wait_for_pattern(self,
+                                'grep xen-platform-pci /proc/interrupts',
+                                'XT-PIC')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.48.1


