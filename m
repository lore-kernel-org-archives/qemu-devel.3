Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA2BD15DB9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 16:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2v1F-00044O-1G; Mon, 21 Oct 2024 12:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2v1A-00042g-0w
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2v17-0003D6-5P
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 12:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729527143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=75heQ1nLomeZi7/Z4nDFOKVgm9AiY4TlyeXK14suY10=;
 b=ea48XfTH64mu4i4VVA4ydUkvqvkgtbnOXpw3gM2KmnjASjGYI9gpHSI+iLLVLhR3e2JB07
 wT0jRXgECI1uEvq6Ex+6tldLYq4rCx+ZHW+NI31a2QiM3bvYHf8LXQ+87oaemFjvvqYMxQ
 pdZFThAvfTo3E/In8rJhGKxVt9y1VDA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-dwhR41ZKOeuTYrCdBSaJ4Q-1; Mon,
 21 Oct 2024 12:12:20 -0400
X-MC-Unique: dwhR41ZKOeuTYrCdBSaJ4Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FCEA1955BCE; Mon, 21 Oct 2024 16:12:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 198FD1956088; Mon, 21 Oct 2024 16:12:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 20/20] tests/functional: Convert the Avocado sh4 tuxrun test
Date: Mon, 21 Oct 2024 18:11:53 +0200
Message-ID: <20241021161156.176427-10-thuth@redhat.com>
In-Reply-To: <20241021161156.176427-1-thuth@redhat.com>
References: <20241021161156.176427-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

Move the test into a new file so that it can be run via
qemu-system-sh4 in the functional framework.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-18-thuth@redhat.com>
---
 MAINTAINERS                         |  1 +
 tests/avocado/tuxrun_baselines.py   | 35 ------------------
 tests/functional/meson.build        |  2 +
 tests/functional/test_sh4_tuxrun.py | 57 +++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 35 deletions(-)
 create mode 100755 tests/functional/test_sh4_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 8777e31fd5..c3bfa132fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1633,6 +1633,7 @@ F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh_intc.h
 F: include/hw/timer/tmu012.h
 F: tests/functional/test_sh4_r2d.py
+F: tests/functional/test_sh4_tuxrun.py
 
 SPARC Machines
 --------------
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
index 80892a0e17..38064840da 100644
--- a/tests/avocado/tuxrun_baselines.py
+++ b/tests/avocado/tuxrun_baselines.py
@@ -222,38 +222,3 @@ def test_arm64be(self):
                  "rootfs.ext4.zst" :
                  "e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7"}
         self.common_tuxrun(csums=sums)
-
-    # Note: some segfaults caused by unaligned userspace access
-    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
-    def test_sh4(self):
-        """
-        :avocado: tags=arch:sh4
-        :avocado: tags=machine:r2d
-        :avocado: tags=cpu:sh7785
-        :avocado: tags=tuxboot:sh4
-        :avocado: tags=image:zImage
-        :avocado: tags=root:sda
-        :avocado: tags=console:ttySC1
-        :avocado: tags=flaky
-        """
-        sums = { "rootfs.ext4.zst" :
-                 "3592a7a3d5a641e8b9821449e77bc43c9904a56c30d45da0694349cfd86743fd",
-                 "zImage" :
-                 "29d9b2aba604a0f53a5dc3b5d0f2b8e35d497de1129f8ee5139eb6fdf0db692f" }
-
-        # The test is currently too unstable to do much in userspace
-        # so we skip common_tuxrun and do a minimal boot and shutdown.
-        (kernel, disk, dtb) = self.fetch_tuxrun_assets(csums=sums)
-
-        # the console comes on the second serial port
-        self.prepare_run(kernel, disk,
-                         "driver=ide-hd,bus=ide.0,unit=0",
-                         console_index=1)
-        self.vm.launch()
-
-        self.wait_for_console_pattern("Welcome to TuxTest")
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
-        exec_command_and_wait_for_pattern(self, 'halt',
-                                          "reboot: System halted")
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 6c62ca2334..5ccc1aa66d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -154,8 +154,10 @@ tests_s390x_system_thorough = [
 
 tests_sh4_system_thorough = [
   'sh4_r2d',
+  'sh4_tuxrun',
 ]
 
+
 tests_sparc_system_thorough = [
   'sparc_sun4m',
 ]
diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/test_sh4_tuxrun.py
new file mode 100755
index 0000000000..352cb360ef
--- /dev/null
+++ b/tests/functional/test_sh4_tuxrun.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots known good tuxboot images the same way
+# that tuxrun (www.tuxrun.org) does. This tool is used by things like
+# the LKFT project to run regression tests on kernels.
+#
+# Copyright (c) 2023 Linaro Ltd.
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import time
+
+from unittest import skipUnless
+from qemu_test import Asset, exec_command_and_wait_for_pattern, exec_command
+from qemu_test.tuxruntest import TuxRunBaselineTest
+
+class TuxRunSh4Test(TuxRunBaselineTest):
+
+    ASSET_SH4_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/sh4/zImage',
+        '29d9b2aba604a0f53a5dc3b5d0f2b8e35d497de1129f8ee5139eb6fdf0db692f')
+    ASSET_SH4_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/sh4/rootfs.ext4.zst',
+        '3592a7a3d5a641e8b9821449e77bc43c9904a56c30d45da0694349cfd86743fd')
+
+    # Note: some segfaults caused by unaligned userspace access
+    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable')
+    def test_sh4(self):
+        self.set_machine('r2d')
+        self.cpu='sh7785'
+        self.root='sda'
+        self.console='ttySC1'
+
+        # The test is currently too unstable to do much in userspace
+        # so we skip common_tuxrun and do a minimal boot and shutdown.
+        (kernel, disk, dtb) = self.fetch_tuxrun_assets(self.ASSET_SH4_KERNEL,
+                                                       self.ASSET_SH4_ROOTFS)
+
+        # the console comes on the second serial port
+        self.prepare_run(kernel, disk,
+                         "driver=ide-hd,bus=ide.0,unit=0",
+                         console_index=1)
+        self.vm.launch()
+
+        self.wait_for_console_pattern("Welcome to TuxTest")
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self, 'halt',
+                                          "reboot: System halted")
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.47.0


