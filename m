Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695C9D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhr-0002xO-Dh; Mon, 21 Oct 2024 07:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhf-0002oh-JK
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qhZ-0001mJ-My
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xS1xkLREns5UYecBft9xrCHMwWOowBmZA5PQsZRtpCA=;
 b=i3GNxcD5T7+LyYXgSfk53TZZ//zU66GFq5/xFTpGL0/tD9IZlaEUBLBrGb5zacCQfwctdw
 elW2T5bNGkXRC7UKd6ZKgz/9Y8mtfnHkKCJqqUaoo6Q28I7LK7jwJG7xT1gFjD5lFkvhNu
 uehGKmE66D+gXP7lM8Wt2En8G2Q2PU8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-4QycRctgMn-fwm5qSjSgZQ-1; Mon,
 21 Oct 2024 07:35:53 -0400
X-MC-Unique: 4QycRctgMn-fwm5qSjSgZQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B75519560AD; Mon, 21 Oct 2024 11:35:52 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 069531955E84; Mon, 21 Oct 2024 11:35:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 21/21] tests/functional: Convert the Avocado sh4 tuxrun test
Date: Mon, 21 Oct 2024 13:34:58 +0200
Message-ID: <20241021113500.122500-22-thuth@redhat.com>
In-Reply-To: <20241021113500.122500-1-thuth@redhat.com>
References: <20241021113500.122500-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

Since this was the last test in tests/avocado/tuxrun_baselines.py,
we can now delete that file completely.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-18-thuth@redhat.com>
---
 MAINTAINERS                         |   4 +-
 tests/avocado/tuxrun_baselines.py   | 228 ----------------------------
 tests/functional/meson.build        |   2 +
 tests/functional/test_sh4_tuxrun.py |  57 +++++++
 4 files changed, 62 insertions(+), 229 deletions(-)
 delete mode 100644 tests/avocado/tuxrun_baselines.py
 create mode 100755 tests/functional/test_sh4_tuxrun.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 213d2ff6f3..957d1998b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1634,6 +1634,7 @@ F: hw/timer/sh_timer.c
 F: include/hw/sh4/sh_intc.h
 F: include/hw/timer/tmu012.h
 F: tests/functional/test_sh4_r2d.py
+F: tests/functional/test_sh4_tuxrun.py
 
 SPARC Machines
 --------------
@@ -4093,7 +4094,8 @@ F: scripts/ci/
 F: tests/docker/
 F: tests/vm/
 F: tests/lcitool/
-F: tests/avocado/tuxrun_baselines.py
+F: tests/functional/qemu_test/tuxruntest.py
+F: tests/functional/test_*_tuxrun.py
 F: scripts/archive-source.sh
 F: docs/devel/testing.rst
 W: https://gitlab.com/qemu-project/qemu/pipelines
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
deleted file mode 100644
index c358095e1f..0000000000
--- a/tests/avocado/tuxrun_baselines.py
+++ /dev/null
@@ -1,228 +0,0 @@
-# Functional test that boots known good tuxboot images the same way
-# that tuxrun (www.tuxrun.org) does. This tool is used by things like
-# the LKFT project to run regression tests on kernels.
-#
-# Copyright (c) 2023 Linaro Ltd.
-#
-# Author:
-#  Alex Bennée <alex.bennee@linaro.org>
-#
-# SPDX-License-Identifier: GPL-2.0-or-later
-
-import os
-import time
-import tempfile
-
-from avocado import skip, skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command, exec_command_and_wait_for_pattern
-from avocado_qemu import wait_for_console_pattern
-from avocado.utils import process
-from avocado.utils.path import find_command
-
-class TuxRunBaselineTest(QemuSystemTest):
-    """
-    :avocado: tags=accel:tcg
-    """
-
-    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0'
-    # Tests are ~10-40s, allow for --debug/--enable-gcov overhead
-    timeout = 100
-
-    def get_tag(self, tagname, default=None):
-        """
-        Get the metadata tag or return the default.
-        """
-        utag = self._get_unique_tag_val(tagname)
-        print(f"{tagname}/{default} -> {utag}")
-        if utag:
-            return utag
-
-        return default
-
-    def setUp(self):
-        super().setUp()
-
-        # We need zstd for all the tuxrun tests
-        # See https://github.com/avocado-framework/avocado/issues/5609
-        zstd = find_command('zstd', False)
-        if zstd is False:
-            self.cancel('Could not find "zstd", which is required to '
-                        'decompress rootfs')
-        self.zstd = zstd
-
-        # Process the TuxRun specific tags, most machines work with
-        # reasonable defaults but we sometimes need to tweak the
-        # config. To avoid open coding everything we store all these
-        # details in the metadata for each test.
-
-        # The tuxboot tag matches the root directory
-        self.tuxboot = self.get_tag('tuxboot')
-
-        # Most Linux's use ttyS0 for their serial port
-        self.console = self.get_tag('console', "ttyS0")
-
-        # Does the machine shutdown QEMU nicely on "halt"
-        self.shutdown = self.get_tag('shutdown')
-
-        # The name of the kernel Image file
-        self.image = self.get_tag('image', "Image")
-
-        self.root = self.get_tag('root', "vda")
-
-        # Occasionally we need extra devices to hook things up
-        self.extradev = self.get_tag('extradev')
-
-        self.qemu_img = super().get_qemu_img()
-
-    def wait_for_console_pattern(self, success_message, vm=None):
-        wait_for_console_pattern(self, success_message,
-                                 failure_message='Kernel panic - not syncing',
-                                 vm=vm)
-
-    def fetch_tuxrun_assets(self, csums=None, dt=None):
-        """
-        Fetch the TuxBoot assets. They are stored in a standard way so we
-        use the per-test tags to fetch details.
-        """
-        base_url = f"https://storage.tuxboot.com/20230331/{self.tuxboot}/"
-
-        # empty hash if we weren't passed one
-        csums = {} if csums is None else csums
-        ksum = csums.get(self.image, None)
-        isum = csums.get("rootfs.ext4.zst", None)
-
-        kernel_image =  self.fetch_asset(base_url + self.image,
-                                         asset_hash = ksum,
-                                         algorithm = "sha256")
-        disk_image_zst = self.fetch_asset(base_url + "rootfs.ext4.zst",
-                                         asset_hash = isum,
-                                         algorithm = "sha256")
-
-        cmd = f"{self.zstd} -d {disk_image_zst} -o {self.workdir}/rootfs.ext4"
-        process.run(cmd)
-
-        if dt:
-            dsum = csums.get(dt, None)
-            dtb = self.fetch_asset(base_url + dt,
-                                   asset_hash = dsum,
-                                   algorithm = "sha256")
-        else:
-            dtb = None
-
-        return (kernel_image, self.workdir + "/rootfs.ext4", dtb)
-
-    def prepare_run(self, kernel, disk, drive, dtb=None, console_index=0):
-        """
-        Setup to run and add the common parameters to the system
-        """
-        self.vm.set_console(console_index=console_index)
-
-        # all block devices are raw ext4's
-        blockdev = "driver=raw,file.driver=file," \
-            + f"file.filename={disk},node-name=hd0"
-
-        kcmd_line = self.KERNEL_COMMON_COMMAND_LINE
-        kcmd_line += f" root=/dev/{self.root}"
-        kcmd_line += f" console={self.console}"
-
-        self.vm.add_args('-kernel', kernel,
-                         '-append', kcmd_line,
-                         '-blockdev', blockdev)
-
-        # Sometimes we need extra devices attached
-        if self.extradev:
-            self.vm.add_args('-device', self.extradev)
-
-        self.vm.add_args('-device',
-                         f"{drive},drive=hd0")
-
-        # Some machines need an explicit DTB
-        if dtb:
-            self.vm.add_args('-dtb', dtb)
-
-    def run_tuxtest_tests(self, haltmsg):
-        """
-        Wait for the system to boot up, wait for the login prompt and
-        then do a few things on the console. Trigger a shutdown and
-        wait to exit cleanly.
-        """
-        self.wait_for_console_pattern("Welcome to TuxTest")
-        time.sleep(0.2)
-        exec_command(self, 'root')
-        time.sleep(0.2)
-        exec_command(self, 'cat /proc/interrupts')
-        time.sleep(0.1)
-        exec_command(self, 'cat /proc/self/maps')
-        time.sleep(0.1)
-        exec_command(self, 'uname -a')
-        time.sleep(0.1)
-        exec_command_and_wait_for_pattern(self, 'halt', haltmsg)
-
-        # Wait for VM to shut down gracefully if it can
-        if self.shutdown == "nowait":
-            self.vm.shutdown()
-        else:
-            self.vm.wait()
-
-    def common_tuxrun(self,
-                      csums=None,
-                      dt=None,
-                      drive="virtio-blk-device",
-                      haltmsg="reboot: System halted",
-                      console_index=0):
-        """
-        Common path for LKFT tests. Unless we need to do something
-        special with the command line we can process most things using
-        the tag metadata.
-        """
-        (kernel, disk, dtb) = self.fetch_tuxrun_assets(csums, dt)
-
-        self.prepare_run(kernel, disk, drive, dtb, console_index)
-        self.vm.launch()
-        self.run_tuxtest_tests(haltmsg)
-
-
-    #
-    # The tests themselves. The configuration is derived from how
-    # tuxrun invokes qemu (with minor tweaks like using -blockdev
-    # consistently). The tuxrun equivalent is something like:
-    #
-    # tuxrun --device qemu-{ARCH} \
-    #        --kernel https://storage.tuxboot.com/{TUXBOOT}/{IMAGE}
-    #
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
index c17c9b0700..51d1037d96 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -156,8 +156,10 @@ tests_s390x_system_thorough = [
 
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


