Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B33FCD4847
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:46:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnRO-00049D-8g; Wed, 04 Sep 2024 06:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRL-0003lX-V7
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnRI-0000Kb-7V
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y5mZs695czUogmzraJY2qRyPsApXIWz/S/3xK0uHCbs=;
 b=CYurK7DE0TEw7ve9D30ric2mUQvmU6ptT1JCxANxxML7Daxhd/MqYfK8M8uGDm0v8Ppwuu
 Ge6kgFxJa04GoZAasVd1PBZYWz2earcvZqing2+3l6ARVPlUwbnkRzGpnvz86UCtXVn4In
 VUPD7zXJoG2MGoYIl0Dl4Y1AzilkDnE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-BbsUrh5dP1-o9sykR6qd-A-1; Wed,
 04 Sep 2024 06:40:36 -0400
X-MC-Unique: BbsUrh5dP1-o9sykR6qd-A-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83A331955D44; Wed,  4 Sep 2024 10:40:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A3A5195605A; Wed,  4 Sep 2024 10:40:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 24/42] tests/functional: Convert most ppc avocado tests into
 standalone tests
Date: Wed,  4 Sep 2024 12:38:59 +0200
Message-ID: <20240904103923.451847-25-thuth@redhat.com>
In-Reply-To: <20240904103923.451847-1-thuth@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Nothing thrilling in here, just straight forward conversions.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240830133841.142644-26-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  9 +--
 tests/functional/meson.build                  | 11 ++++
 .../test_ppc64_powernv.py}                    | 56 +++++-----------
 .../test_ppc64_pseries.py}                    | 56 +++++-----------
 .../test_ppc_40p.py}                          | 65 +++++++++----------
 .../test_ppc_mpc8544ds.py}                    | 29 +++++----
 .../test_ppc_virtex_ml507.py}                 | 29 +++++----
 7 files changed, 113 insertions(+), 142 deletions(-)
 rename tests/{avocado/ppc_powernv.py => functional/test_ppc64_powernv.py} (71%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_pseries.py => functional/test_ppc64_pseries.py} (76%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_prep_40p.py => functional/test_ppc_40p.py} (51%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_mpc8544ds.py => functional/test_ppc_mpc8544ds.py} (55%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_virtex_ml507.py => functional/test_ppc_virtex_ml507.py} (60%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 7180667d37..cb55ead291 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1453,7 +1453,7 @@ L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/mpc8544ds.c
 F: hw/ppc/mpc8544_guts.c
-F: tests/avocado/ppc_mpc8544ds.py
+F: tests/functional/test_ppc_mpc8544ds.py
 
 New World (mac99)
 M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
@@ -1506,7 +1506,7 @@ F: hw/dma/i82374.c
 F: hw/rtc/m48t59-isa.c
 F: include/hw/isa/pc87312.h
 F: include/hw/rtc/m48t59.h
-F: tests/avocado/ppc_prep_40p.py
+F: tests/functional/test_ppc_40p.py
 
 sPAPR (pseries)
 M: Nicholas Piggin <npiggin@gmail.com>
@@ -1530,7 +1530,7 @@ F: tests/qtest/spapr*
 F: tests/qtest/libqos/*spapr*
 F: tests/qtest/rtas*
 F: tests/qtest/libqos/rtas*
-F: tests/avocado/ppc_pseries.py
+F: tests/functional/test_ppc64_pseries.py
 F: tests/avocado/ppc_hv_tests.py
 
 PowerNV (Non-Virtualized)
@@ -1548,6 +1548,7 @@ F: include/hw/ppc/pnv*
 F: include/hw/pci-host/pnv*
 F: pc-bios/skiboot.lid
 F: tests/qtest/pnv*
+F: tests/functional/test_ppc64_powernv.py
 
 pca955x
 M: Glenn Miles <milesg@linux.ibm.com>
@@ -1562,7 +1563,7 @@ M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 L: qemu-ppc@nongnu.org
 S: Odd Fixes
 F: hw/ppc/virtex_ml507.c
-F: tests/avocado/ppc_virtex_ml507.py
+F: tests/functional/test_ppc_virtex_ml507.py
 
 sam460ex
 M: BALATON Zoltan <balaton@eik.bme.hu>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8e4ea9cff7..38aaa03a58 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -12,6 +12,9 @@ endif
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
   'netdev_ethtool' : 180,
+  'ppc_40p' : 240,
+  'ppc64_powernv' : 120,
+  'ppc64_pseries' : 120,
   's390x_ccw_virtio' : 180,
 }
 
@@ -57,7 +60,15 @@ tests_ppc_system_quick = [
 
 tests_ppc_system_thorough = [
   'ppc_405',
+  'ppc_40p',
   'ppc_bamboo',
+  'ppc_mpc8544ds',
+  'ppc_virtex_ml507',
+]
+
+tests_ppc64_system_thorough = [
+  'ppc64_powernv',
+  'ppc64_pseries',
 ]
 
 tests_s390x_system_thorough = [
diff --git a/tests/avocado/ppc_powernv.py b/tests/functional/test_ppc64_powernv.py
old mode 100644
new mode 100755
similarity index 71%
rename from tests/avocado/ppc_powernv.py
rename to tests/functional/test_ppc64_powernv.py
index 4342941d5d..67497d6404
--- a/tests/avocado/ppc_powernv.py
+++ b/tests/functional/test_ppc64_powernv.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test that Linux kernel boots on ppc powernv machines and check the console
 #
 # Copyright (c) 2018, 2020 Red Hat, Inc.
@@ -5,9 +7,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
 
 class powernvMachine(QemuSystemTest):
 
@@ -16,13 +17,14 @@ class powernvMachine(QemuSystemTest):
     panic_message = 'Kernel panic - not syncing'
     good_message = 'VFS: Cannot open root device'
 
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
+         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
+        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
+
     def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
         self.require_accelerator("tcg")
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
-                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
-                      '/ppc/ppc64/vmlinuz')
-        kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        kernel_path = self.ASSET_KERNEL.fetch()
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_path,
@@ -30,23 +32,13 @@ def do_test_linux_boot(self, command_line = KERNEL_COMMON_COMMAND_LINE):
         self.vm.launch()
 
     def test_linux_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv
-        :avocado: tags=accel:tcg
-        """
-
+        self.set_machine('powernv')
         self.do_test_linux_boot()
         console_pattern = 'VFS: Cannot open root device'
         wait_for_console_pattern(self, console_pattern, self.panic_message)
 
     def test_linux_smp_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv
-        :avocado: tags=accel:tcg
-        """
-
+        self.set_machine('powernv')
         self.vm.add_args('-smp', '4')
         self.do_test_linux_boot()
         console_pattern = 'smp: Brought up 1 node, 4 CPUs'
@@ -54,12 +46,7 @@ def test_linux_smp_boot(self):
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
     def test_linux_smp_hpt_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv
-        :avocado: tags=accel:tcg
-        """
-
+        self.set_machine('powernv')
         self.vm.add_args('-smp', '4')
         self.do_test_linux_boot(self.KERNEL_COMMON_COMMAND_LINE +
                                 'disable_radix')
@@ -70,12 +57,7 @@ def test_linux_smp_hpt_boot(self):
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
     def test_linux_smt_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv
-        :avocado: tags=accel:tcg
-        """
-
+        self.set_machine('powernv')
         self.vm.add_args('-smp', '4,threads=4')
         self.do_test_linux_boot()
         console_pattern = 'CPU maps initialized for 4 threads per core'
@@ -85,12 +67,7 @@ def test_linux_smt_boot(self):
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
     def test_linux_big_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv
-        :avocado: tags=accel:tcg
-        """
-
+        self.set_machine('powernv')
         self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
 
         # powernv does not support NUMA
@@ -100,3 +77,6 @@ def test_linux_big_boot(self):
         console_pattern = 'smp: Brought up 2 nodes, 16 CPUs'
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/ppc_pseries.py b/tests/functional/test_ppc64_pseries.py
old mode 100644
new mode 100755
similarity index 76%
rename from tests/avocado/ppc_pseries.py
rename to tests/functional/test_ppc64_pseries.py
index 74aaa4ac4a..fdc404ed03
--- a/tests/avocado/ppc_pseries.py
+++ b/tests/functional/test_ppc64_pseries.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test that Linux kernel boots on ppc machines and check the console
 #
 # Copyright (c) 2018, 2020 Red Hat, Inc.
@@ -5,9 +7,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
 
 class pseriesMachine(QemuSystemTest):
 
@@ -16,12 +17,13 @@ class pseriesMachine(QemuSystemTest):
     panic_message = 'Kernel panic - not syncing'
     good_message = 'VFS: Cannot open root device'
 
+    ASSET_KERNEL = Asset(
+        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
+         'releases/29/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
+        '383c2f5c23bc0d9d32680c3924d3fd7ee25cc5ef97091ac1aa5e1d853422fc5f')
+
     def do_test_ppc64_linux_boot(self, kernel_command_line = KERNEL_COMMON_COMMAND_LINE):
-        kernel_url = ('https://archives.fedoraproject.org/pub/archive'
-                      '/fedora-secondary/releases/29/Everything/ppc64le/os'
-                      '/ppc/ppc64/vmlinuz')
-        kernel_hash = '3fe04abfc852b66653b8c3c897a59a689270bc77'
-        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
+        kernel_path = self.ASSET_KERNEL.fetch()
 
         self.vm.set_console()
         self.vm.add_args('-kernel', kernel_path,
@@ -29,32 +31,20 @@ def do_test_ppc64_linux_boot(self, kernel_command_line = KERNEL_COMMON_COMMAND_L
         self.vm.launch()
 
     def test_ppc64_vof_linux_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        """
-
+        self.set_machine('pseries')
         self.vm.add_args('-machine', 'x-vof=on')
         self.do_test_ppc64_linux_boot()
         console_pattern = 'VFS: Cannot open root device'
         wait_for_console_pattern(self, console_pattern, self.panic_message)
 
     def test_ppc64_linux_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        """
-
+        self.set_machine('pseries')
         self.do_test_ppc64_linux_boot()
         console_pattern = 'VFS: Cannot open root device'
         wait_for_console_pattern(self, console_pattern, self.panic_message)
 
     def test_ppc64_linux_smp_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        """
-
+        self.set_machine('pseries')
         self.vm.add_args('-smp', '4')
         self.do_test_ppc64_linux_boot()
         console_pattern = 'smp: Brought up 1 node, 4 CPUs'
@@ -62,11 +52,7 @@ def test_ppc64_linux_smp_boot(self):
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
     def test_ppc64_linux_hpt_smp_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        """
-
+        self.set_machine('pseries')
         self.vm.add_args('-smp', '4')
         self.do_test_ppc64_linux_boot(self.KERNEL_COMMON_COMMAND_LINE +
                                       'disable_radix')
@@ -77,11 +63,6 @@ def test_ppc64_linux_hpt_smp_boot(self):
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
     def test_ppc64_linux_smt_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        """
-
         self.vm.add_args('-smp', '4,threads=4')
         self.do_test_ppc64_linux_boot()
         console_pattern = 'CPU maps initialized for 4 threads per core'
@@ -91,11 +72,7 @@ def test_ppc64_linux_smt_boot(self):
         wait_for_console_pattern(self, self.good_message, self.panic_message)
 
     def test_ppc64_linux_big_boot(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        """
-
+        self.set_machine('pseries')
         self.vm.add_args('-smp', '16,threads=4,cores=2,sockets=2')
         self.vm.add_args('-m', '512M',
                          '-object', 'memory-backend-ram,size=256M,id=m0',
@@ -108,3 +85,6 @@ def test_ppc64_linux_big_boot(self):
         console_pattern = 'smp: Brought up 2 nodes, 16 CPUs'
         wait_for_console_pattern(self, console_pattern, self.panic_message)
         wait_for_console_pattern(self, self.good_message, self.panic_message)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/ppc_prep_40p.py b/tests/functional/test_ppc_40p.py
old mode 100644
new mode 100755
similarity index 51%
rename from tests/avocado/ppc_prep_40p.py
rename to tests/functional/test_ppc_40p.py
index d4f1eb7e1d..c64e876c1f
--- a/tests/avocado/ppc_prep_40p.py
+++ b/tests/functional/test_ppc_40p.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Functional test that boots a PReP/40p machine and checks its serial console.
 #
 # Copyright (c) Philippe Mathieu-Daudé <f4bug@amsat.org>
@@ -7,39 +9,40 @@
 
 import os
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from unittest import skipUnless
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
 
 
 class IbmPrep40pMachine(QemuSystemTest):
 
     timeout = 60
 
+    ASSET_BIOS = Asset(
+        ('http://ftpmirror.your.org/pub/misc/'
+         'ftp.software.ibm.com/rs6000/firmware/'
+         '7020-40p/P12H0456.IMG'),
+        'd957f79c73f760d1455d2286fcd901ed6d06167320eb73511b478a939be25b3f')
+    ASSET_NETBSD40 = Asset(
+        ('https://archive.netbsd.org/pub/NetBSD-archive/'
+         'NetBSD-4.0/prep/installation/floppy/generic_com0.fs'),
+        'f86236e9d01b3f0dd0f5d3b8d5bbd40c68e78b4db560a108358f5ad58e636619')
+    ASSET_NETBSD71 = Asset(
+        ('https://archive.netbsd.org/pub/NetBSD-archive/'
+         'NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso'),
+        'cc7cb290b06aaa839362deb7bd9f417ac5015557db24088508330f76c3f825ec')
+
     # 12H0455 PPS Firmware Licensed Materials
     # Property of IBM (C) Copyright IBM Corp. 1994.
     # All rights reserved.
     # U.S. Government Users Restricted Rights - Use, duplication or disclosure
     # restricted by GSA ADP Schedule Contract with IBM Corp.
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_factory_firmware_and_netbsd(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:40p
-        :avocado: tags=os:netbsd
-        :avocado: tags=slowness:high
-        :avocado: tags=accel:tcg
-        """
+        self.set_machine('40p')
         self.require_accelerator("tcg")
-        bios_url = ('http://ftpmirror.your.org/pub/misc/'
-                    'ftp.software.ibm.com/rs6000/firmware/'
-                    '7020-40p/P12H0456.IMG')
-        bios_hash = '1775face4e6dc27f3a6ed955ef6eb331bf817f03'
-        bios_path = self.fetch_asset(bios_url, asset_hash=bios_hash)
-        drive_url = ('https://archive.netbsd.org/pub/NetBSD-archive/'
-                     'NetBSD-4.0/prep/installation/floppy/generic_com0.fs')
-        drive_hash = 'dbcfc09912e71bd5f0d82c7c1ee43082fb596ceb'
-        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash)
+        bios_path = self.ASSET_BIOS.fetch()
+        drive_path = self.ASSET_NETBSD40.fetch()
 
         self.vm.set_console()
         self.vm.add_args('-bios', bios_path,
@@ -50,11 +53,7 @@ def test_factory_firmware_and_netbsd(self):
         wait_for_console_pattern(self, 'Model: IBM PPS Model 6015')
 
     def test_openbios_192m(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:40p
-        :avocado: tags=accel:tcg
-        """
+        self.set_machine('40p')
         self.require_accelerator("tcg")
         self.vm.set_console()
         self.vm.add_args('-m', '192') # test fw_cfg
@@ -65,21 +64,15 @@ def test_openbios_192m(self):
         wait_for_console_pattern(self, '>> CPU type PowerPC,604')
 
     def test_openbios_and_netbsd(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:40p
-        :avocado: tags=os:netbsd
-        :avocado: tags=accel:tcg
-        """
+        self.set_machine('40p')
         self.require_accelerator("tcg")
-        drive_url = ('https://archive.netbsd.org/pub/NetBSD-archive/'
-                     'NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso')
-        drive_hash = 'ac6fa2707d888b36d6fa64de6e7fe48e'
-        drive_path = self.fetch_asset(drive_url, asset_hash=drive_hash,
-                                      algorithm='md5')
+        drive_path = self.ASSET_NETBSD71.fetch()
         self.vm.set_console()
         self.vm.add_args('-cdrom', drive_path,
                          '-boot', 'd')
 
         self.vm.launch()
         wait_for_console_pattern(self, 'NetBSD/prep BOOT, Revision 1.9')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/ppc_mpc8544ds.py b/tests/functional/test_ppc_mpc8544ds.py
old mode 100644
new mode 100755
similarity index 55%
rename from tests/avocado/ppc_mpc8544ds.py
rename to tests/functional/test_ppc_mpc8544ds.py
index b599fb1cc9..2b3f0894ae
--- a/tests/avocado/ppc_mpc8544ds.py
+++ b/tests/functional/test_ppc_mpc8544ds.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test that Linux kernel boots on ppc machines and check the console
 #
 # Copyright (c) 2018, 2020 Red Hat, Inc.
@@ -5,9 +7,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test.utils import archive_extract
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
 
 class Mpc8544dsMachine(QemuSystemTest):
 
@@ -15,20 +17,21 @@ class Mpc8544dsMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
     panic_message = 'Kernel panic - not syncing'
 
+    ASSET_IMAGE = Asset(
+        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
+         'day04.tar.xz'),
+        '88bc83f3c9f3d633bcfc108a6342d677abca247066a2fb8d4636744a0d319f94')
+
     def test_ppc_mpc8544ds(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:mpc8544ds
-        :avocado: tags=accel:tcg
-        """
         self.require_accelerator("tcg")
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day04.tar.xz')
-        tar_hash = 'f46724d281a9f30fa892d458be7beb7d34dc25f9'
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
+        self.set_machine('mpc8544ds')
+        file_path = self.ASSET_IMAGE.fetch()
+        archive_extract(file_path, self.workdir, member='creek/creek.bin')
         self.vm.set_console()
         self.vm.add_args('-kernel', self.workdir + '/creek/creek.bin')
         self.vm.launch()
         wait_for_console_pattern(self, 'QEMU advent calendar 2020',
                                  self.panic_message)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/ppc_virtex_ml507.py b/tests/functional/test_ppc_virtex_ml507.py
old mode 100644
new mode 100755
similarity index 60%
rename from tests/avocado/ppc_virtex_ml507.py
rename to tests/functional/test_ppc_virtex_ml507.py
index a73f8ae396..ffa9a0633e
--- a/tests/avocado/ppc_virtex_ml507.py
+++ b/tests/functional/test_ppc_virtex_ml507.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test that Linux kernel boots on ppc machines and check the console
 #
 # Copyright (c) 2018, 2020 Red Hat, Inc.
@@ -5,9 +7,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test.utils import archive_extract
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
 
 class VirtexMl507Machine(QemuSystemTest):
 
@@ -15,18 +17,16 @@ class VirtexMl507Machine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
     panic_message = 'Kernel panic - not syncing'
 
+    ASSET_IMAGE = Asset(
+        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
+         'day08.tar.xz'),
+        'cefe5b8aeb5e9d2d1d4fd22dcf48d917d68d5a765132bf2ddd6332dc393b824c')
+
     def test_ppc_virtex_ml507(self):
-        """
-        :avocado: tags=arch:ppc
-        :avocado: tags=machine:virtex-ml507
-        :avocado: tags=accel:tcg
-        """
         self.require_accelerator("tcg")
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day08.tar.xz')
-        tar_hash = '74c68f5af7a7b8f21c03097b298f3bb77ff52c1f'
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
+        self.set_machine('virtex-ml507')
+        file_path = self.ASSET_IMAGE.fetch()
+        archive_extract(file_path, self.workdir)
         self.vm.set_console()
         self.vm.add_args('-kernel', self.workdir + '/hippo/hippo.linux',
                          '-dtb', self.workdir + '/hippo/virtex440-ml507.dtb',
@@ -34,3 +34,6 @@ def test_ppc_virtex_ml507(self):
         self.vm.launch()
         wait_for_console_pattern(self, 'QEMU advent calendar 2020',
                                  self.panic_message)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


