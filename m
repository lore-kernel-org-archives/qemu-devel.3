Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFBEC5321D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 08:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sggjk-0000dm-Sz; Wed, 21 Aug 2024 04:30:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggj9-0005ZR-5q
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sggj0-0004Xm-A6
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724228984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QeiUwMhPRS+4HNy8UzfJsEwrqqDAvlOKeuqq2/uOD6o=;
 b=dBNFo00d7cBds9gnWuhPQErwiGvWythYeo//CxDGPOI3716URMoBx3l76tcGEXpzRemXkL
 lYzU++zdCON86nnxoizeN2TnJBZxUCvwxFkryWnqyDk82jc94nxSxk8k9Bw+YhBQRXHx4W
 JfWg5bT/XJgsxIP7+anDp1D/25V6bR0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-JEWPiiI7PY-TvEFhZhzy7A-1; Wed,
 21 Aug 2024 04:29:40 -0400
X-MC-Unique: JEWPiiI7PY-TvEFhZhzy7A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70D2E1935D3B; Wed, 21 Aug 2024 08:29:37 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 69C791953B9A; Wed, 21 Aug 2024 08:29:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 26/35] tests/functional: Convert the ppc_hv avocado test
 into a standalone test
Date: Wed, 21 Aug 2024 10:27:27 +0200
Message-ID: <20240821082748.65853-27-thuth@redhat.com>
In-Reply-To: <20240821082748.65853-1-thuth@redhat.com>
References: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A straight forward conversion, we just also have to remove the decorator
@skipUnless(os.getenv('SPEED')) since all non-trivial functional tests
are running in SPEED=thorough mode now. Also make sure that the extracted
assets are writable, so that the test does not fail if it gets re-run
and there are stale read-only files already around.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |  2 +-
 tests/functional/meson.build                  |  2 +
 .../test_ppc64_hv.py}                         | 53 ++++++++-----------
 3 files changed, 25 insertions(+), 32 deletions(-)
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
index fba3891e16..f90fb08d6a 100644
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
@@ -63,6 +64,7 @@ tests_ppc_thorough = [
 ]
 
 tests_ppc64_thorough = [
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
index 0e83bbac71..df59667e07
--- a/tests/avocado/ppc_hv_tests.py
+++ b/tests/functional/test_ppc64_hv.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Tests that specifically try to exercise hypervisor features of the
 # target machines. powernv supports the Power hypervisor ISA, and
 # pseries supports the nested-HV hypervisor spec.
@@ -7,10 +9,10 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado import skipIf, skipUnless
-from avocado.utils import archive
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern, exec_command
+from unittest import skipIf, skipUnless
+from qemu_test.utils import archive_extract
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern, exec_command
 import os
 import time
 import subprocess
@@ -45,8 +47,7 @@ def missing_deps():
 # QEMU already installed and use that.
 # XXX: The order of these tests seems to matter, see git blame.
 @skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
-@skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
-@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
+@skipUnless(os.getenv('QEMU_TEST_ALLOW_LARGE_STORAGE'), 'storage limited')
 class HypervisorTest(QemuSystemTest):
 
     timeout = 1000
@@ -54,6 +55,11 @@ class HypervisorTest(QemuSystemTest):
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
@@ -72,6 +78,7 @@ def extract_from_iso(self, iso, path):
             subprocess.run(cmd.split(),
                            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
 
+        os.chmod(filename, 0o600)
         os.chdir(cwd)
 
         # Return complete path to extracted file.  Because callers to
@@ -83,16 +90,9 @@ def extract_from_iso(self, iso, path):
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
@@ -158,12 +158,8 @@ def do_test_kvm(self, hpt=False):
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
@@ -173,12 +169,8 @@ def test_hv_pseries(self):
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
@@ -188,12 +180,8 @@ def test_hv_pseries_kvm(self):
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
@@ -203,3 +191,6 @@ def test_hv_powernv(self):
         self.do_test_kvm()
         self.do_test_kvm(True)
         self.do_stop_alpine()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.46.0


