Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A46EC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 08:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sggii-0003RJ-0L; Wed, 21 Aug 2024 04:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggia-0002kZ-7j
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:29:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggiM-0004Tx-Dy
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724228949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gx2Qe3oi3sZb449dBfC+DaTA40QT1Bj9GLP51ptpwjg=;
 b=PTISkZUylHxejbGxwL+Ny3MrE1poDH2ij2gF9/L0EmDOAZMVH0rGCbj8gNlZ6BQ1dmtkqq
 CPG1LCuLiNyWkgi6FyGn/E0sftTB/clhpSyu+bFmfVf5Dy4FdJu6g+FvXkr4IKyHiY/dFO
 uD9WZZ4Fc7h6Fwdvg7FCHabBgEacKQ8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-MR6yaW6iOjCzwn3ek9PB8w-1; Wed,
 21 Aug 2024 04:29:04 -0400
X-MC-Unique: MR6yaW6iOjCzwn3ek9PB8w-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A90D91955D52; Wed, 21 Aug 2024 08:29:02 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 98A581955DD8; Wed, 21 Aug 2024 08:28:59 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 19/35] tests/functional: Convert the s390x avocado tests
 into standalone tests
Date: Wed, 21 Aug 2024 10:27:20 +0200
Message-ID: <20240821082748.65853-20-thuth@redhat.com>
In-Reply-To: <20240821082748.65853-1-thuth@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

These tests use archive.lzma_uncompress() from the Avocado utils,
so provide a small helper function for this, based on the
standard lzma module from Python instead.

And while we're at it, replace the MD5 hashes in the topology test
with proper SHA256 hashes, since MD5 should not be used anymore
nowadays.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  4 +-
 tests/functional/meson.build                  |  6 ++
 tests/functional/qemu_test/utils.py           | 14 +++
 .../test_s390x_ccw_virtio.py}                 | 79 ++++++++---------
 .../test_s390x_topology.py}                   | 86 ++++++++-----------
 5 files changed, 94 insertions(+), 95 deletions(-)
 rename tests/{avocado/machine_s390_ccw_virtio.py => functional/test_s390x_ccw_virtio.py} (85%)
 mode change 100644 => 100755
 rename tests/{avocado/s390_topology.py => functional/test_s390x_topology.py} (88%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 56dcd56375..7fad267307 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1743,7 +1743,7 @@ S: Supported
 F: hw/s390x/
 F: include/hw/s390x/
 F: configs/devices/s390x-softmmu/default.mak
-F: tests/avocado/machine_s390_ccw_virtio.py
+F: tests/functional/test_s390x_ccw_virtio.py
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
@@ -1806,7 +1806,7 @@ F: hw/s390x/cpu-topology.c
 F: target/s390x/kvm/stsi-topology.c
 F: docs/devel/s390-cpu-topology.rst
 F: docs/system/s390x/cpu-topology.rst
-F: tests/avocado/s390_topology.py
+F: tests/functional/test_s390x_topology.py
 
 X86 Machines
 ------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 91bf80f0f4..ce5e5be2f3 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -12,6 +12,7 @@ endif
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
   'netdev_ethtool' : 180,
+  's390x_ccw_virtio' : 180,
 }
 
 tests_generic = [
@@ -46,6 +47,11 @@ tests_ppc_thorough = [
   'ppc_bamboo',
 ]
 
+tests_s390x_thorough = [
+  's390x_ccw_virtio',
+  's390x_topology',
+]
+
 tests_sparc64_thorough = [
   'sparc64_sun4u',
 ]
diff --git a/tests/functional/qemu_test/utils.py b/tests/functional/qemu_test/utils.py
index 4eb5e5d5e5..a12dac51b6 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -8,6 +8,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import lzma
+import os
+import shutil
 import tarfile
 
 def archive_extract(archive, dest_dir, member=None):
@@ -19,3 +22,14 @@ def archive_extract(archive, dest_dir, member=None):
             tf.extract(member=member, path=dest_dir)
         else:
             tf.extractall(path=dest_dir)
+
+def lzma_uncompress(xz_path, output_path):
+    if os.path.exists(output_path):
+        return
+    with lzma.open(xz_path, 'rb') as lzma_in:
+        try:
+            with open(output_path, 'wb') as raw_out:
+                shutil.copyfileobj(lzma_in, raw_out)
+        except:
+            os.remove(output_path)
+            raise
diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/functional/test_s390x_ccw_virtio.py
old mode 100644
new mode 100755
similarity index 85%
rename from tests/avocado/machine_s390_ccw_virtio.py
rename to tests/functional/test_s390x_ccw_virtio.py
index 7a214110fc..f7acd90a89
--- a/tests/avocado/machine_s390_ccw_virtio.py
+++ b/tests/functional/test_s390x_ccw_virtio.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots an s390x Linux guest with ccw and PCI devices
 # attached and checks whether the devices are recognized by Linux
 #
@@ -12,17 +14,38 @@
 import os
 import tempfile
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import lzma_uncompress
 
 class S390CCWVirtioMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
 
     timeout = 120
 
+    ASSET_BUSTER_KERNEL = Asset(
+        ('https://snapshot.debian.org/archive/debian/'
+         '20201126T092837Z/dists/buster/main/installer-s390x/'
+         '20190702+deb10u6/images/generic/kernel.debian'),
+        'd411d17c39ae7ad38d27534376cbe88b68b403c325739364122c2e6f1537e818')
+    ASSET_BUSTER_INITRD = Asset(
+        ('https://snapshot.debian.org/archive/debian/'
+         '20201126T092837Z/dists/buster/main/installer-s390x/'
+         '20190702+deb10u6/images/generic/initrd.debian'),
+        '836bbd0fe6a5ca81274c28c2b063ea315ce1868660866e9b60180c575fef9fd5')
+
+    ASSET_F31_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive'
+         '/fedora-secondary/releases/31/Server/s390x/os'
+         '/images/kernel.img'),
+        '480859574f3f44caa6cd35c62d70e1ac0609134e22ce2a954bbed9b110c06e0b')
+    ASSET_F31_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive'
+         '/fedora-secondary/releases/31/Server/s390x/os'
+         '/images/initrd.img'),
+        '04c46095b2c49020b1c2327158898b7db747e4892ae319726192fb949716aa9c')
+
     def wait_for_console_pattern(self, success_message, vm=None):
         wait_for_console_pattern(self, success_message,
                                  failure_message='Kernel panic - not syncing',
@@ -41,23 +64,10 @@ def clear_guest_dmesg(self):
         self.dmesg_clear_count += 1
 
     def test_s390x_devices(self):
+        self.set_machine('s390-ccw-virtio')
 
-        """
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
-        """
-
-        kernel_url = ('https://snapshot.debian.org/archive/debian/'
-                      '20201126T092837Z/dists/buster/main/installer-s390x/'
-                      '20190702+deb10u6/images/generic/kernel.debian')
-        kernel_hash = '5821fbee57d6220a067a8b967d24595621aa1eb6'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
-
-        initrd_url = ('https://snapshot.debian.org/archive/debian/'
-                      '20201126T092837Z/dists/buster/main/installer-s390x/'
-                      '20190702+deb10u6/images/generic/initrd.debian')
-        initrd_hash = '81ba09c97bef46e8f4660ac25b4ac0a5be3a94d6'
-        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        kernel_path = self.ASSET_BUSTER_KERNEL.fetch()
+        initrd_path = self.ASSET_BUSTER_INITRD.fetch()
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
@@ -160,29 +170,13 @@ def test_s390x_devices(self):
 
 
     def test_s390x_fedora(self):
+        self.set_machine('s390-ccw-virtio')
 
-        """
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
-        :avocado: tags=device:virtio-gpu
-        :avocado: tags=device:virtio-crypto
-        :avocado: tags=device:virtio-net
-        :avocado: tags=flaky
-        """
-
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
-                      '/fedora-secondary/releases/31/Server/s390x/os'
-                      '/images/kernel.img')
-        kernel_hash = 'b93d1efcafcf29c1673a4ce371a1f8b43941cfeb'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        kernel_path = self.ASSET_F31_KERNEL.fetch()
 
-        initrd_url = ('https://archives.fedoraproject.org/pub/archive'
-                      '/fedora-secondary/releases/31/Server/s390x/os'
-                      '/images/initrd.img')
-        initrd_hash = '3de45d411df5624b8d8ef21cd0b44419ab59b12f'
-        initrd_path_xz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
+        initrd_path_xz = self.ASSET_F31_INITRD.fetch()
         initrd_path = os.path.join(self.workdir, 'initrd-raw.img')
-        archive.lzma_uncompress(initrd_path_xz, initrd_path)
+        lzma_uncompress(initrd_path_xz, initrd_path)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE + ' audit=0 '
@@ -277,3 +271,6 @@ def test_s390x_fedora(self):
         exec_command_and_wait_for_pattern(self,
                         'while ! (dmesg -c | grep Start.virtcrypto_remove) ; do'
                         ' sleep 1 ; done', 'Start virtcrypto_remove.')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/s390_topology.py b/tests/functional/test_s390x_topology.py
old mode 100644
new mode 100755
similarity index 88%
rename from tests/avocado/s390_topology.py
rename to tests/functional/test_s390x_topology.py
index 9154ac8776..20727f6bdf
--- a/tests/avocado/s390_topology.py
+++ b/tests/functional/test_s390x_topology.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a Linux kernel and checks the console
 #
 # Copyright IBM Corp. 2023
@@ -9,16 +11,13 @@
 # later.  See the COPYING file in the top-level directory.
 
 import os
-import shutil
 import time
 
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import interrupt_interactive_console_until_pattern
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import process
-from avocado.utils import archive
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import lzma_uncompress
 
 
 class S390CPUTopology(QemuSystemTest):
@@ -47,6 +46,17 @@ class S390CPUTopology(QemuSystemTest):
                                   'root=/dev/ram '
                                   'selinux=0 '
                                   'rdinit=/bin/sh')
+    ASSET_F35_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive'
+         '/fedora-secondary/releases/35/Server/s390x/os'
+         '/images/kernel.img'),
+        '1f2dddfd11bb1393dd2eb2e784036fbf6fc11057a6d7d27f9eb12d3edc67ef73')
+
+    ASSET_F35_INITRD = Asset(
+        ('https://archives.fedoraproject.org/pub/archive'
+         '/fedora-secondary/releases/35/Server/s390x/os'
+         '/images/initrd.img'),
+        '1100145fbca00240c8c372ae4b89b48c99844bc189b3dfbc3f481dc60055ca46')
 
     def wait_until_booted(self):
         wait_for_console_pattern(self, 'no job control',
@@ -78,21 +88,10 @@ def kernel_init(self):
         We need a minimal root filesystem with a shell.
         """
         self.require_accelerator("kvm")
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
-                      '/fedora-secondary/releases/35/Server/s390x/os'
-                      '/images/kernel.img')
-        kernel_hash = '0d1aaaf303f07cf0160c8c48e56fe638'
-        kernel_path = self.fetch_asset(kernel_url, algorithm='md5',
-                                       asset_hash=kernel_hash)
-
-        initrd_url = ('https://archives.fedoraproject.org/pub/archive'
-                      '/fedora-secondary/releases/35/Server/s390x/os'
-                      '/images/initrd.img')
-        initrd_hash = 'a122057d95725ac030e2ec51df46e172'
-        initrd_path_xz = self.fetch_asset(initrd_url, algorithm='md5',
-                                          asset_hash=initrd_hash)
+        kernel_path = self.ASSET_F35_KERNEL.fetch()
+        initrd_path_xz = self.ASSET_F35_INITRD.fetch()
         initrd_path = os.path.join(self.workdir, 'initrd-raw.img')
-        archive.lzma_uncompress(initrd_path_xz, initrd_path)
+        lzma_uncompress(initrd_path_xz, initrd_path)
 
         self.vm.set_console()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
@@ -115,10 +114,8 @@ def system_init(self):
     def test_single(self):
         """
         This test checks the simplest topology with a single CPU.
-
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
         """
+        self.set_machine('s390-ccw-virtio')
         self.kernel_init()
         self.vm.launch()
         self.wait_until_booted()
@@ -127,10 +124,8 @@ def test_single(self):
     def test_default(self):
         """
         This test checks the implicit topology.
-
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
         """
+        self.set_machine('s390-ccw-virtio')
         self.kernel_init()
         self.vm.add_args('-smp',
                          '13,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
@@ -154,10 +149,8 @@ def test_move(self):
         """
         This test checks the topology modification by moving a CPU
         to another socket: CPU 0 is moved from socket 0 to socket 2.
-
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
         """
+        self.set_machine('s390-ccw-virtio')
         self.kernel_init()
         self.vm.add_args('-smp',
                          '1,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
@@ -174,10 +167,8 @@ def test_dash_device(self):
         """
         This test verifies that a CPU defined with the '-device'
         command line option finds its right place inside the topology.
-
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
         """
+        self.set_machine('s390-ccw-virtio')
         self.kernel_init()
         self.vm.add_args('-smp',
                          '1,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
@@ -221,10 +212,8 @@ def test_polarization(self):
         """
         This test verifies that QEMU modifies the entitlement change after
         several guest polarization change requests.
-
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
         """
+        self.set_machine('s390-ccw-virtio')
         self.kernel_init()
         self.vm.launch()
         self.wait_until_booted()
@@ -267,10 +256,8 @@ def test_entitlement(self):
         """
         This test verifies that QEMU modifies the entitlement
         after a guest request and that the guest sees the change.
-
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
         """
+        self.set_machine('s390-ccw-virtio')
         self.kernel_init()
         self.vm.launch()
         self.wait_until_booted()
@@ -313,10 +300,8 @@ def test_dedicated(self):
         CPU is made dedicated.
         QEMU retains the entitlement value when horizontal polarization is in effect.
         For the guest, the field shows the effective value of the entitlement.
-
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
         """
+        self.set_machine('s390-ccw-virtio')
         self.kernel_init()
         self.vm.launch()
         self.wait_until_booted()
@@ -345,10 +330,8 @@ def test_socket_full(self):
         This test verifies that QEMU does not accept to overload a socket.
         The socket-id 0 on book-id 0 already contains CPUs 0 and 1 and can
         not accept any new CPU while socket-id 0 on book-id 1 is free.
-
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
         """
+        self.set_machine('s390-ccw-virtio')
         self.kernel_init()
         self.vm.add_args('-smp',
                          '3,drawers=2,books=2,sockets=3,cores=2,maxcpus=24')
@@ -369,10 +352,8 @@ def test_dedicated_error(self):
         """
         This test verifies that QEMU refuses to lower the entitlement
         of a dedicated CPU
-
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
         """
+        self.set_machine('s390-ccw-virtio')
         self.kernel_init()
         self.vm.launch()
         self.wait_until_booted()
@@ -417,10 +398,8 @@ def test_move_error(self):
         """
         This test verifies that QEMU refuses to move a CPU to an
         nonexistent location
-
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
         """
+        self.set_machine('s390-ccw-virtio')
         self.kernel_init()
         self.vm.launch()
         self.wait_until_booted()
@@ -437,3 +416,6 @@ def test_move_error(self):
         self.assertEqual(res['error']['class'], 'GenericError')
 
         self.check_topology(0, 0, 0, 0, 'medium', False)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


