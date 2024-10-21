Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5665AD0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qhI-0002B6-HN; Mon, 21 Oct 2024 07:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qh2-00026w-Fm
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qh0-0001hI-PP
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vgCJa3lRaWKDZ5YQG9hJnsfM4gpPiC8xhT/plBG3xHo=;
 b=Xpo+C8qtecsTsNcnKujM8p4QiXIvcE0J8bLmkiZcXG4x3rJnEN0OB7hzvEZndOdt6QLgiz
 bZHRo9gcAhjwZGNaceKSEKo75Lw5CckX/YB9yaiYBa9bFsM2/YUytonLL6zDghhbHbMJ9r
 3ulgunIeFZdBodXUmuOfWi2cWvm/03c=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-364-aL5D13iwNBa6nr2EtZ2erQ-1; Mon,
 21 Oct 2024 07:35:19 -0400
X-MC-Unique: aL5D13iwNBa6nr2EtZ2erQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 47B3519560BC; Mon, 21 Oct 2024 11:35:18 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 720C119560AA; Mon, 21 Oct 2024 11:35:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/21] tests/functional: Add a base class for the TuxRun tests
Date: Mon, 21 Oct 2024 13:34:42 +0200
Message-ID: <20241021113500.122500-6-thuth@redhat.com>
In-Reply-To: <20241021113500.122500-1-thuth@redhat.com>
References: <20241021113500.122500-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a base class for the TuxRun tests, based on the code from
tests/avocado/tuxrun_baselines.py (the test have to be put into
separate file in the following commits, depending on the target
architecture that gets tested).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241011131937.377223-2-thuth@redhat.com>
---
 tests/functional/qemu_test/tuxruntest.py | 158 +++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 tests/functional/qemu_test/tuxruntest.py

diff --git a/tests/functional/qemu_test/tuxruntest.py b/tests/functional/qemu_test/tuxruntest.py
new file mode 100644
index 0000000000..904da6f609
--- /dev/null
+++ b/tests/functional/qemu_test/tuxruntest.py
@@ -0,0 +1,158 @@
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
+from qemu_test import QemuSystemTest
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+from qemu_test import has_cmd, run_cmd, get_qemu_img
+
+class TuxRunBaselineTest(QemuSystemTest):
+
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0'
+    # Tests are ~10-40s, allow for --debug/--enable-gcov overhead
+    timeout = 100
+
+    def get_tag(self, tagname, default=None):
+        """
+        Get the metadata tag or return the default.
+        """
+        utag = self._get_unique_tag_val(tagname)
+        print(f"{tagname}/{default} -> {utag}")
+        if utag:
+            return utag
+
+        return default
+
+    def setUp(self):
+        super().setUp()
+
+        # We need zstd for all the tuxrun tests
+        # See https://github.com/avocado-framework/avocado/issues/5609
+        (has_zstd, msg) = has_cmd('zstd')
+        if has_zstd is False:
+            self.skipTest(msg)
+        self.zstd = 'zstd'
+
+        # Pre-init TuxRun specific settings: Most machines work with
+        # reasonable defaults but we sometimes need to tweak the
+        # config. To avoid open coding everything we store all these
+        # details in the metadata for each test.
+
+        # The tuxboot tag matches the root directory
+        self.tuxboot = self.arch
+
+        # Most Linux's use ttyS0 for their serial port
+        self.console = "ttyS0"
+
+        # Does the machine shutdown QEMU nicely on "halt"
+        self.wait_for_shutdown = True
+
+        self.root = "vda"
+
+        # Occasionally we need extra devices to hook things up
+        self.extradev = None
+
+        self.qemu_img = get_qemu_img(self)
+
+    def wait_for_console_pattern(self, success_message, vm=None):
+        wait_for_console_pattern(self, success_message,
+                                 failure_message='Kernel panic - not syncing',
+                                 vm=vm)
+
+    def fetch_tuxrun_assets(self, kernel_asset, rootfs_asset, dtb_asset=None):
+        """
+        Fetch the TuxBoot assets.
+        """
+        kernel_image =  kernel_asset.fetch()
+        disk_image_zst = rootfs_asset.fetch()
+
+        run_cmd([self.zstd, "-f", "-d", disk_image_zst,
+                 "-o", self.workdir + "/rootfs.ext4"])
+
+        dtb = dtb_asset.fetch() if dtb_asset is not None else None
+
+        return (kernel_image, self.workdir + "/rootfs.ext4", dtb)
+
+    def prepare_run(self, kernel, disk, drive, dtb=None, console_index=0):
+        """
+        Setup to run and add the common parameters to the system
+        """
+        self.vm.set_console(console_index=console_index)
+
+        # all block devices are raw ext4's
+        blockdev = "driver=raw,file.driver=file," \
+            + f"file.filename={disk},node-name=hd0"
+
+        kcmd_line = self.KERNEL_COMMON_COMMAND_LINE
+        kcmd_line += f" root=/dev/{self.root}"
+        kcmd_line += f" console={self.console}"
+
+        self.vm.add_args('-kernel', kernel,
+                         '-append', kcmd_line,
+                         '-blockdev', blockdev)
+
+        # Sometimes we need extra devices attached
+        if self.extradev:
+            self.vm.add_args('-device', self.extradev)
+
+        self.vm.add_args('-device',
+                         f"{drive},drive=hd0")
+
+        # Some machines need an explicit DTB
+        if dtb:
+            self.vm.add_args('-dtb', dtb)
+
+    def run_tuxtest_tests(self, haltmsg):
+        """
+        Wait for the system to boot up, wait for the login prompt and
+        then do a few things on the console. Trigger a shutdown and
+        wait to exit cleanly.
+        """
+        self.wait_for_console_pattern("Welcome to TuxTest")
+        time.sleep(0.2)
+        exec_command(self, 'root')
+        time.sleep(0.2)
+        exec_command(self, 'cat /proc/interrupts')
+        time.sleep(0.1)
+        exec_command(self, 'cat /proc/self/maps')
+        time.sleep(0.1)
+        exec_command(self, 'uname -a')
+        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self, 'halt', haltmsg)
+
+        # Wait for VM to shut down gracefully if it can
+        if self.wait_for_shutdown:
+            self.vm.wait()
+        else:
+            self.vm.shutdown()
+
+    def common_tuxrun(self,
+                      kernel_asset,
+                      rootfs_asset,
+                      dtb_asset=None,
+                      drive="virtio-blk-device",
+                      haltmsg="reboot: System halted",
+                      console_index=0):
+        """
+        Common path for LKFT tests. Unless we need to do something
+        special with the command line we can process most things using
+        the tag metadata.
+        """
+        (kernel, disk, dtb) = self.fetch_tuxrun_assets(kernel_asset, rootfs_asset,
+                                                       dtb_asset)
+
+        self.prepare_run(kernel, disk, drive, dtb, console_index)
+        self.vm.launch()
+        self.run_tuxtest_tests(haltmsg)
+        os.remove(disk)
-- 
2.47.0


