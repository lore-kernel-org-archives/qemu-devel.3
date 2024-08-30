Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8016ACA0FF3
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 13:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sk1s8-0005TJ-4a; Fri, 30 Aug 2024 09:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1s4-00056q-PN
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:41:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sk1s0-0005Z3-Rh
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 09:41:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725025256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rYDWIbt492k6BlYyTYOTTMPprueU9AFZYQIxleZGdDM=;
 b=a0AUKlbumxdtQHooxScF4Dyut4DS+4fVz1X075IaYQCdVcIzhPXwN3DJqEA5wZ5CIV77Ue
 vWwN50JrytdOw+uqelXboGLCLXNdvxpXwhjuRFWd3qy2AcCBWngyhiheyqT87FdOWRnZ/a
 5OIsiy4XXqg6N1Hyt2WkuEeA65tYxwA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-7nUotcXIPVO9MH7QRYYasg-1; Fri,
 30 Aug 2024 09:40:53 -0400
X-MC-Unique: 7nUotcXIPVO9MH7QRYYasg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F26F1955D5A; Fri, 30 Aug 2024 13:40:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.7])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 05A703001FC3; Fri, 30 Aug 2024 13:40:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 27/44] tests/functional: Convert the ppc_hv avocado test
 into a standalone test
Date: Fri, 30 Aug 2024 15:38:21 +0200
Message-ID: <20240830133841.142644-28-thuth@redhat.com>
In-Reply-To: <20240830133841.142644-1-thuth@redhat.com>
References: <20240830133841.142644-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

A straight forward conversion, we just also have to remove the decorator
@skipUnless(os.getenv('SPEED')) since all non-trivial functional tests
are running in SPEED=thorough mode now. Also make sure that the extracted
assets are writable, so that the test does not fail if it gets re-run
and there are stale read-only files already around.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  2 +
 .../test_ppc64_hv.py}                         | 52 ++++++++-----------
 3 files changed, 24 insertions(+), 32 deletions(-)
 rename tests/{avocado/ppc_hv_tests.py => functional/test_ppc64_hv.py} (85%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index f01e865025..cca48683ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1532,7 +1532,7 @@ F: tests/qtest/libqos/*spapr*
 F: tests/qtest/rtas*
 F: tests/qtest/libqos/rtas*
 F: tests/functional/test_ppc64_pseries.py
-F: tests/avocado/ppc_hv_tests.py
+F: tests/functional/test_ppc64_hv.py
 
 PowerNV (Non-Virtualized)
 M: Cédric Le Goater <clg@kaod.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8f46a90003..1b2e6d142c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,7 @@ endif
 test_timeouts = {
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
+  'ppc64_hv' : 1000,
   'ppc64_powernv' : 120,
   'ppc64_pseries' : 120,
   's390x_ccw_virtio' : 180,
@@ -69,6 +70,7 @@ tests_ppc_system_thorough = [
 ]
 
 tests_ppc64_system_thorough = [
+  'ppc64_hv',
   'ppc64_powernv',
   'ppc64_pseries',
 ]
diff --git a/tests/avocado/ppc_hv_tests.py b/tests/functional/test_ppc64_hv.py
old mode 100644
new mode 100755
similarity index 85%
rename from tests/avocado/ppc_hv_tests.py
rename to tests/functional/test_ppc64_hv.py
index 0e83bbac71..1a6e4b6d07
--- a/tests/avocado/ppc_hv_tests.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Tests that specifically try to exercise hypervisor features of the
 # target machines. powernv supports the Power hypervisor ISA, and
 # pseries supports the nested-HV hypervisor spec.
@@ -7,10 +9,9 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado import skipIf, skipUnless
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern, exec_command
+from unittest import skipIf, skipUnless
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern, exec_command
 import os
 import time
 import subprocess
@@ -45,8 +46,7 @@ def missing_deps():
 # QEMU already installed and use that.
 # XXX: The order of these tests seems to matter, see git blame.
 @skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
-@skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
-@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
+@skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
 class HypervisorTest(QemuSystemTest):
 
     timeout = 1000
@@ -54,6 +54,11 @@ class HypervisorTest(QemuSystemTest):
     panic_message = 'Kernel panic - not syncing'
     good_message = 'VFS: Cannot open root device'
 
+    ASSET_ISO = Asset(
+        ('https://dl-cdn.alpinelinux.org/alpine/v3.18/'
+         'releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso'),
+        'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff')
+
     def extract_from_iso(self, iso, path):
         """
         Extracts a file from an iso file into the test workdir
@@ -72,6 +77,7 @@ def extract_from_iso(self, iso, path):
             subprocess.run(cmd.split(),
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
 
+        os.chmod(filename, 0o600)
         os.chdir(cwd)
 
         # Return complete path to extracted file.  Because callers to
@@ -83,16 +89,9 @@ def extract_from_iso(self, iso, path):
     def setUp(self):
         super().setUp()
 
-        iso_url = ('https://dl-cdn.alpinelinux.org/alpine/v3.18/releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso')
-
-        # Alpine use sha256 so I recalculated this myself
-        iso_sha256 = 'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff'
-        iso_path = self.fetch_asset(iso_url, asset_hash=iso_sha256,
-                                    algorithm = "sha256")
-
-        self.iso_path = iso_path
-        self.vmlinuz = self.extract_from_iso(iso_path, '/boot/vmlinuz-lts')
-        self.initramfs = self.extract_from_iso(iso_path, '/boot/initramfs-lts')
+        self.iso_path = self.ASSET_ISO.fetch()
+        self.vmlinuz = self.extract_from_iso(self.iso_path, '/boot/vmlinuz-lts')
+        self.initramfs = self.extract_from_iso(self.iso_path, '/boot/initramfs-lts')
 
     def do_start_alpine(self):
         self.vm.set_console()
@@ -158,12 +157,8 @@ def do_test_kvm(self, hpt=False):
         wait_for_console_pattern(self, 'alpine:~#')
 
     def test_hv_pseries(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        :avocado: tags=accel:tcg
-        """
         self.require_accelerator("tcg")
+        self.set_machine('pseries')
         self.vm.add_args("-accel", "tcg,thread=multi")
         self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
         self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on")
@@ -173,12 +168,8 @@ def test_hv_pseries(self):
         self.do_stop_alpine()
 
     def test_hv_pseries_kvm(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:pseries
-        :avocado: tags=accel:kvm
-        """
         self.require_accelerator("kvm")
+        self.set_machine('pseries')
         self.vm.add_args("-accel", "kvm")
         self.vm.add_args('-device', 'nvme,serial=1234,drive=drive0')
         self.vm.add_args("-machine", "x-vof=on,cap-nested-hv=on,cap-ccf-assist=off")
@@ -188,12 +179,8 @@ def test_hv_pseries_kvm(self):
         self.do_stop_alpine()
 
     def test_hv_powernv(self):
-        """
-        :avocado: tags=arch:ppc64
-        :avocado: tags=machine:powernv
-        :avocado: tags=accel:tcg
-        """
         self.require_accelerator("tcg")
+        self.set_machine('powernv')
         self.vm.add_args("-accel", "tcg,thread=multi")
         self.vm.add_args('-device', 'nvme,bus=pcie.2,addr=0x0,serial=1234,drive=drive0',
                          '-device', 'e1000e,netdev=net0,mac=C0:FF:EE:00:00:02,bus=pcie.0,addr=0x0',
@@ -203,3 +190,6 @@ def test_hv_powernv(self):
         self.do_test_kvm()
         self.do_test_kvm(True)
         self.do_stop_alpine()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


