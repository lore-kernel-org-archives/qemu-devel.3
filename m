Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 788EBC3DA61
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 17:56:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWgD0-0001Xy-Ix; Wed, 24 Jul 2024 13:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCS-0007FI-14
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:54:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sWgCO-000603-PY
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 13:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721843687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMvhKTE2qsY+wTNyXs0fBA34JiorTFeyb34Ousut7VU=;
 b=OqZm9SNMJ4Wn2qRl2f3AlhEtGjlQ41VEoi3tHGr010aouIyhQbCSbu9ZzAWH80e9FTmso9
 Bi1a4YRKcpHudCuo4z8Au1cWzG9+SBvastGmUYID6ursZT62h5Yi7yyYxCUmpJ2tXocwSs
 a/HCrBkWGG1vJ3kg9A1lUre5dpOSXzw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-FTFiEbJyN9StYKXoO29StQ-1; Wed,
 24 Jul 2024 13:54:44 -0400
X-MC-Unique: FTFiEbJyN9StYKXoO29StQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C98F1944B29; Wed, 24 Jul 2024 17:54:43 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E49C1955D42; Wed, 24 Jul 2024 17:54:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-ppc@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 19/23] tests/functional: Convert the ppc_hv avocado test
 into a standalone test
Date: Wed, 24 Jul 2024 19:52:37 +0200
Message-ID: <20240724175248.1389201-20-thuth@redhat.com>
In-Reply-To: <20240724175248.1389201-1-thuth@redhat.com>
References: <20240724175248.1389201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.136,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Note: The original Avocado test seems currently to be broken, it hangs
when the guest is trying to install additional packages. So mark it as
broken for now until it gets fixed.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../test_ppc64_hv.py}                         | 36 ++++++++-----------
 1 file changed, 14 insertions(+), 22 deletions(-)
 rename tests/{avocado/ppc_hv_tests.py => functional/test_ppc64_hv.py} (92%)
 mode change 100644 => 100755

diff --git a/tests/avocado/ppc_hv_tests.py b/tests/functional/test_ppc64_hv.py
old mode 100644
new mode 100755
similarity index 92%
rename from tests/avocado/ppc_hv_tests.py
rename to tests/functional/test_ppc64_hv.py
index bf8822bb97..acba3e01b9
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
+from qemu_test import QemuSystemTest
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
@@ -88,8 +90,7 @@ def setUp(self):
 
         # Alpine use sha256 so I recalculated this myself
         iso_sha256 = 'c26b8d3e17c2f3f0fed02b4b1296589c2390e6d5548610099af75300edd7b3ff'
-        iso_path = self.fetch_asset(iso_url, asset_hash=iso_sha256,
-                                    algorithm = "sha256")
+        iso_path = self.fetch_asset(iso_url, asset_hash=iso_sha256)
 
         self.iso_path = iso_path
         self.vmlinuz = self.extract_from_iso(iso_path, '/boot/vmlinuz-lts')
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


