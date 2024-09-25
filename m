Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F7CC369CC
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPvU-0008WI-Hr; Wed, 25 Sep 2024 07:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPvR-0008Cg-6j
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:11:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPvN-0003W6-S6
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rG65tNp8WBpfFC12CRuEEP/MkfjZPyk7nXSdbTG2z4=;
 b=JPW2/xc5UFUfIQLbhhND7ur+7bh0Hqn0/IiwfNlHN09DL1TyVpAdd+cbAbQsLwGnsvRduJ
 vtOYWGwsYNNUDHQQhqEoctoGehKKot4YhI34e8fO5iBzqlILvSRiTL5QSdPr2ie3wqrML6
 5KKNr1qKHZepQLM1VLI0vg5ERzQlgrw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-KCXOxyUGN1eH6vVnrQvPPg-1; Wed,
 25 Sep 2024 07:11:02 -0400
X-MC-Unique: KCXOxyUGN1eH6vVnrQvPPg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5AB11944DF4; Wed, 25 Sep 2024 11:10:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DEE2B1956094; Wed, 25 Sep 2024 11:10:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 07/44] tests/functional: Convert the r2d sh4 Avocado test
Date: Wed, 25 Sep 2024 13:09:48 +0200
Message-ID: <20240925111029.24082-8-thuth@redhat.com>
In-Reply-To: <20240925111029.24082-1-thuth@redhat.com>
References: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is the last test that is using the do_test_advcal_2018()
function, so we can now remove that function from boot_linux_console.py,
too.

Message-ID: <20240919185749.71222-8-thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                         |  1 +
 tests/avocado/boot_linux_console.py | 25 -----------------------
 tests/functional/meson.build        |  4 ++++
 tests/functional/test_sh4_r2d.py    | 31 +++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 25 deletions(-)
 create mode 100755 tests/functional/test_sh4_r2d.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 63eb306d6e..62f5255f40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1679,6 +1679,7 @@ F: hw/pci-host/sh_pci.c
 F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh_intc.h
 F: include/hw/timer/tmu012.h
+F: tests/functional/test_sh4_r2d.py
 
 SPARC Machines
 --------------
diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index f5dc9e9cfa..759fda9cc8 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -882,17 +882,6 @@ def test_arm_orangepi_uboot_netbsd9(self):
         # Wait for user-space
         wait_for_console_pattern(self, 'Starting root file system check')
 
-    def do_test_advcal_2018(self, day, tar_hash, kernel_name, console=0):
-        tar_url = ('https://qemu-advcal.gitlab.io'
-                   '/qac-best-of-multiarch/download/day' + day + '.tar.xz')
-        file_path = self.fetch_asset(tar_url, asset_hash=tar_hash)
-        archive.extract(file_path, self.workdir)
-        self.vm.set_console(console_index=console)
-        self.vm.add_args('-kernel',
-                         self.workdir + '/day' + day + '/' + kernel_name)
-        self.vm.launch()
-        self.wait_for_console_pattern('QEMU advent calendar')
-
     def test_arm_ast2600_debian(self):
         """
         :avocado: tags=arch:arm
@@ -964,17 +953,3 @@ def test_ppc_powernv10(self):
         :avocado: tags=accel:tcg
         """
         self.do_test_ppc64_powernv('P10')
-
-    # This test has a 6-10% failure rate on various hosts that look
-    # like issues with a buggy kernel. As a result we don't want it
-    # gating releases on Gitlab.
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_sh4_r2d(self):
-        """
-        :avocado: tags=arch:sh4
-        :avocado: tags=machine:r2d
-        :avocado: tags=flaky
-        """
-        tar_hash = 'fe06a4fd8ccbf2e27928d64472939d47829d4c7e'
-        self.vm.add_args('-append', 'console=ttySC1')
-        self.do_test_advcal_2018('09', tar_hash, 'zImage', console=1)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 449c6a95ea..56a541530f 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -127,6 +127,10 @@ tests_s390x_system_thorough = [
   's390x_topology',
 ]
 
+tests_sh4_system_thorough = [
+  'sh4_r2d',
+]
+
 tests_sparc_system_thorough = [
   'sparc_sun4m',
 ]
diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/test_sh4_r2d.py
new file mode 100755
index 0000000000..5fe8cf9f8d
--- /dev/null
+++ b/tests/functional/test_sh4_r2d.py
@@ -0,0 +1,31 @@
+#!/usr/bin/env python3
+#
+# Boot a Linux kernel on a r2d sh4 machine and check the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+from unittest import skipUnless
+
+class R2dTest(LinuxKernelTest):
+
+    ASSET_DAY09 = Asset(
+        'https://www.qemu-advent-calendar.org/2018/download/day09.tar.xz',
+        'a61b44d2630a739d1380cc4ff4b80981d47ccfd5992f1484ccf48322c35f09ac')
+
+    # This test has a 6-10% failure rate on various hosts that look
+    # like issues with a buggy kernel.
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
+    def test_r2d(self):
+        self.set_machine('r2d')
+        file_path = self.ASSET_DAY09.fetch()
+        archive_extract(file_path, self.workdir)
+        self.vm.add_args('-append', 'console=ttySC1')
+        self.launch_kernel(self.workdir + '/day09/zImage', console_index=1,
+                           wait_for='QEMU advent calendar')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.46.0


