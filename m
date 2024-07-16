Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F05C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgLO-00029i-V2; Tue, 16 Jul 2024 07:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKu-000113-Mx
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKp-0003hA-VV
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721129224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cQC9YgpQ0Go3a4yLyP+3PWN3jDPG9o3cRP2hX1hIGP0=;
 b=gsr2fogGJKgx4UQ3imwhrl4/mm2In0pyj94kHViP0dJ1QE828uaqstNvrCaaIapt5eqR36
 TwEIBl5noJoCWxR/43OiJ232CzxQqen94ZdYNDa12VKVvbAFdtrBMjXa5jf4jhG/Z0VkG4
 jxXKGvPLuMDyD71Q7E79DB3WyLq/1H4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-0XJ36HnjMGKvkaxXfL0Ybw-1; Tue,
 16 Jul 2024 07:27:00 -0400
X-MC-Unique: 0XJ36HnjMGKvkaxXfL0Ybw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7083B1944A8F; Tue, 16 Jul 2024 11:26:59 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0A7281955F40; Tue, 16 Jul 2024 11:26:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 10/11] tests/functional: Convert the s390x avocado tests into
 standalone tests
Date: Tue, 16 Jul 2024 13:26:13 +0200
Message-ID: <20240716112614.1755692-11-thuth@redhat.com>
In-Reply-To: <20240716112614.1755692-1-thuth@redhat.com>
References: <20240716112614.1755692-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  4 +-
 tests/functional/meson.build                  |  6 ++
 tests/functional/qemu_test/utils.py           |  7 ++
 .../test_s390x_ccw_virtio.py}                 | 32 ++++-----
 .../test_s390x_topology.py}                   | 70 +++++++------------
 5 files changed, 52 insertions(+), 67 deletions(-)
 rename tests/{avocado/machine_s390_ccw_virtio.py => functional/test_s390x_ccw_virtio.py} (95%)
 mode change 100644 => 100755
 rename tests/{avocado/s390_topology.py => functional/test_s390x_topology.py} (90%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 025227954c..cbefb6fb81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1739,7 +1739,7 @@ S: Supported
 F: hw/s390x/
 F: include/hw/s390x/
 F: configs/devices/s390x-softmmu/default.mak
-F: tests/avocado/machine_s390_ccw_virtio.py
+F: tests/functional/test_s390x_ccw_virtio.py
 T: git https://github.com/borntraeger/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
@@ -1802,7 +1802,7 @@ F: hw/s390x/cpu-topology.c
 F: target/s390x/kvm/stsi-topology.c
 F: docs/devel/s390-cpu-topology.rst
 F: docs/system/s390x/cpu-topology.rst
-F: tests/avocado/s390_topology.py
+F: tests/functional/test_s390x_topology.py
 
 X86 Machines
 ------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index c8fc9f6c07..f6de9af8a2 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,7 @@ endif
 test_timeouts = {
   'netdev_ethtool' : 180,
   'ppc_74xx' : 90,
+  's390x_ccw_virtio' : 180,
 }
 
 tests_generic = [
@@ -47,6 +48,11 @@ tests_ppc_thorough = [
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
index 4eb5e5d5e5..8115d9d1da 100644
--- a/tests/functional/qemu_test/utils.py
+++ b/tests/functional/qemu_test/utils.py
@@ -8,6 +8,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
+import lzma
+import shutil
 import tarfile
 
 def archive_extract(archive, dest_dir, member=None):
@@ -19,3 +21,8 @@ def archive_extract(archive, dest_dir, member=None):
             tf.extract(member=member, path=dest_dir)
         else:
             tf.extractall(path=dest_dir)
+
+def lzma_uncompress(xz_path, output_path):
+    with lzma.open(xz_path, 'rb') as lzma_in:
+        with open(output_path, 'wb') as raw_out:
+            shutil.copyfileobj(lzma_in, raw_out)
diff --git a/tests/avocado/machine_s390_ccw_virtio.py b/tests/functional/test_s390x_ccw_virtio.py
old mode 100644
new mode 100755
similarity index 95%
rename from tests/avocado/machine_s390_ccw_virtio.py
rename to tests/functional/test_s390x_ccw_virtio.py
index 26e938c9e9..b2cbaacd21
--- a/tests/avocado/machine_s390_ccw_virtio.py
+++ b/tests/functional/test_s390x_ccw_virtio.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots an s390x Linux guest with ccw and PCI devices
 # attached and checks whether the devices are recognized by Linux
 #
@@ -12,11 +14,10 @@
 import os
 import tempfile
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import archive
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import lzma_uncompress
 
 class S390CCWVirtioMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -41,11 +42,7 @@ def clear_guest_dmesg(self):
         self.dmesg_clear_count += 1
 
     def test_s390x_devices(self):
-
-        """
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
-        """
+        self.set_machine('s390-ccw-virtio')
 
         kernel_url = ('https://snapshot.debian.org/archive/debian/'
                       '20201126T092837Z/dists/buster/main/installer-s390x/'
@@ -160,15 +157,7 @@ def test_s390x_devices(self):
 
 
     def test_s390x_fedora(self):
-
-        """
-        :avocado: tags=arch:s390x
-        :avocado: tags=machine:s390-ccw-virtio
-        :avocado: tags=device:virtio-gpu
-        :avocado: tags=device:virtio-crypto
-        :avocado: tags=device:virtio-net
-        :avocado: tags=flaky
-        """
+        self.set_machine('s390-ccw-virtio')
 
         kernel_url = ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/31/Server/s390x/os'
@@ -182,7 +171,7 @@ def test_s390x_fedora(self):
         initrd_hash = '3de45d411df5624b8d8ef21cd0b44419ab59b12f'
         initrd_path_xz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
         initrd_path = os.path.join(self.workdir, 'initrd-raw.img')
-        archive.lzma_uncompress(initrd_path_xz, initrd_path)
+        lzma_uncompress(initrd_path_xz, initrd_path)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE + ' audit=0 '
@@ -275,3 +264,6 @@ def test_s390x_fedora(self):
         exec_command_and_wait_for_pattern(self,
                         'while ! (dmesg -c | grep Start.virtcrypto_remove) ; do'
                         ' sleep 1 ; done', 'Start virtcrypto_remove.')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/s390_topology.py b/tests/functional/test_s390x_topology.py
old mode 100644
new mode 100755
similarity index 90%
rename from tests/avocado/s390_topology.py
rename to tests/functional/test_s390x_topology.py
index 9154ac8776..39c5ce0b3d
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
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+from qemu_test.utils import lzma_uncompress
 
 
 class S390CPUTopology(QemuSystemTest):
@@ -81,18 +80,16 @@ def kernel_init(self):
         kernel_url = ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/35/Server/s390x/os'
                       '/images/kernel.img')
-        kernel_hash = '0d1aaaf303f07cf0160c8c48e56fe638'
-        kernel_path = self.fetch_asset(kernel_url, algorithm='md5',
-                                       asset_hash=kernel_hash)
+        kernel_hash = '1f2dddfd11bb1393dd2eb2e784036fbf6fc11057a6d7d27f9eb12d3edc67ef73'
+        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
 
         initrd_url = ('https://archives.fedoraproject.org/pub/archive'
                       '/fedora-secondary/releases/35/Server/s390x/os'
                       '/images/initrd.img')
-        initrd_hash = 'a122057d95725ac030e2ec51df46e172'
-        initrd_path_xz = self.fetch_asset(initrd_url, algorithm='md5',
-                                          asset_hash=initrd_hash)
+        initrd_hash = '1100145fbca00240c8c372ae4b89b48c99844bc189b3dfbc3f481dc60055ca46'
+        initrd_path_xz = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
         initrd_path = os.path.join(self.workdir, 'initrd-raw.img')
-        archive.lzma_uncompress(initrd_path_xz, initrd_path)
+        lzma_uncompress(initrd_path_xz, initrd_path)
 
         self.vm.set_console()
         kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE
@@ -115,10 +112,8 @@ def system_init(self):
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
@@ -127,10 +122,8 @@ def test_single(self):
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
@@ -154,10 +147,8 @@ def test_move(self):
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
@@ -174,10 +165,8 @@ def test_dash_device(self):
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
@@ -221,10 +210,8 @@ def test_polarization(self):
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
@@ -267,10 +254,8 @@ def test_entitlement(self):
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
@@ -313,10 +298,8 @@ def test_dedicated(self):
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
@@ -345,10 +328,8 @@ def test_socket_full(self):
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
@@ -369,10 +350,8 @@ def test_dedicated_error(self):
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
@@ -417,10 +396,8 @@ def test_move_error(self):
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
@@ -437,3 +414,6 @@ def test_move_error(self):
         self.assertEqual(res['error']['class'], 'GenericError')
 
         self.check_topology(0, 0, 0, 0, 'medium', False)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


