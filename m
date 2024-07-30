Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 886B2C49EA1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:06:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqHt-0003T0-Ru; Tue, 30 Jul 2024 13:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHp-00036Q-Gk
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqHn-0002jr-GT
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359118;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hKIGpvZb7jk+f/kwB0EeVexIpR89KbT/QbkbhkDpD/A=;
 b=KfsMfq0ymOZLuPKQ2OTaj7CMn5h9qYZt4xbz0BZYoUMG61nk37thGArZ3pnP6DfBhsk/9U
 G/4g5zDRHf386nwyRDvRhotwLWS+eCkn7TNkLilLxVvGWj038yo6cfxqX2L8FII8hjFuL+
 wvh02J7ROLJr53dMBtv5d7fb34RHsEQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-2zVwWK43PYicCTwU84Ztyg-1; Tue,
 30 Jul 2024 13:05:15 -0400
X-MC-Unique: 2zVwWK43PYicCTwU84Ztyg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCE4B19560B1; Tue, 30 Jul 2024 17:05:13 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BDB5300018D; Tue, 30 Jul 2024 17:05:10 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 20/24] tests/functional: Convert the ppc_hv avocado test
 into a standalone test
Date: Tue, 30 Jul 2024 18:03:40 +0100
Message-ID: <20240730170347.4103919-21-berrange@redhat.com>
In-Reply-To: <20240730170347.4103919-1-berrange@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Note: The original Avocado test seems currently to be broken, it hangs
when the guest is trying to install additional packages. So mark it as
broken for now until it gets fixed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../test_ppc64_hv.py}                         | 48 ++++++++-----------
 1 file changed, 20 insertions(+), 28 deletions(-)
 rename tests/{avocado/ppc_hv_tests.py => functional/test_ppc64_hv.py} (88%)
 mode change 100644 => 100755

diff --git a/tests/avocado/ppc_hv_tests.py b/tests/functional/test_ppc64_hv.py
old mode 100644
new mode 100755
similarity index 88%
rename from tests/avocado/ppc_hv_tests.py
rename to tests/functional/test_ppc64_hv.py
index bf8822bb97..a45657c87e
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
@@ -47,7 +49,7 @@ def missing_deps():
 @skipIf(missing_deps(), 'dependencies (%s) not installed' % ','.join(deps))
 @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets stuck due to console handling problem')
 @skipUnless(os.getenv('AVOCADO_ALLOW_LARGE_STORAGE'), 'storage limited')
-@skipUnless(os.getenv('SPEED') == 'slow', 'runtime limited')
+@skip('broken test - guest fails to install packages')
 class HypervisorTest(QemuSystemTest):
 
     timeout = 1000
@@ -55,6 +57,12 @@ class HypervisorTest(QemuSystemTest):
     panic_message = 'Kernel panic - not syncing'
     good_message = 'VFS: Cannot open root device'
 
+    # Alpine use sha256 so I recalculated this myself
+    ASSET_ISO = Asset(
+        ('https://dl-cdn.alpinelinux.org/alpine/v3.18/'
+         'releases/ppc64le/alpine-standard-3.18.4-ppc64le.iso'),
+        'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff')
+
     def extract_from_iso(self, iso, path):
         """
         Extracts a file from an iso file into the test workdir
@@ -84,14 +92,7 @@ def extract_from_iso(self, iso, path):
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
+        self.iso_path = self.ASSET_ISO.fetch()
         self.vmlinuz = self.extract_from_iso(iso_path, '/boot/vmlinuz-lts')
         self.initramfs = self.extract_from_iso(iso_path, '/boot/initramfs-lts')
 
@@ -159,12 +160,8 @@ def do_test_kvm(self, hpt=False):
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
@@ -174,12 +171,8 @@ def test_hv_pseries(self):
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
@@ -189,12 +182,8 @@ def test_hv_pseries_kvm(self):
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
@@ -204,3 +193,6 @@ def test_hv_powernv(self):
         self.do_test_kvm()
         self.do_test_kvm(True)
         self.do_stop_alpine()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


