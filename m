Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ABED58D5D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFayq-00070K-DG; Mon, 25 Nov 2024 10:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFaym-0006wt-FW
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:24 -0500
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFayh-0002YK-CO
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:26:22 -0500
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-53de27f1478so1643397e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548377; x=1733153177; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hs4NIJpS4GDhESrRpIniIOaaQZDtuYfQr9U5rHDCt0U=;
 b=bskyjQcK1/diK/CKaSuLBh6qs0OXqMDzAuB/L9ZzK+FKcOB7k0V/O+LuDadZ390G5P
 1KRTbFhynU65hHkKwbCrAidME2iNbgifejRdRfZam7SD5W2SgL5RWv6IAlJdjyHZFzYI
 eQXKp0y10GIgwi7IRnoZtJj6gXNe/PNJVH1gBOiw6TKmkheXS/aIeUP7aLenhRZmqO7D
 da4Gz490y6IGx4mvMvHFMBWEsAzh1ldaLtGcCVKZPu5lepsA69EaTfojyiNc0Z4igcqs
 b9s2vki8ZLUv4gWVHQtc6WCtPfcBfKP29VHDJ1c3LVoKIX/MGmTna4yYcyNQ7bcKiGbH
 IyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548377; x=1733153177;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hs4NIJpS4GDhESrRpIniIOaaQZDtuYfQr9U5rHDCt0U=;
 b=LO5c4OHQwMFKmIHuhF2FXlYf5tFJYB+0LLtKfsp6SWr7xKVOMF58adNrMJokjKhd4G
 NkjM/A/f4Tw6kvWp/5Tg626F1KHEvTeodr22ltfDR+GCAFc/6JokTSwLUP+SkGWEEmjQ
 wpWjjld70T1qoHOGX1QsnlFTehnzO8+HuUedOTAjAKXN/J3UQM6M33Dnu5AtPL3kSsrt
 GDmWjJ3HjjQ+6Q2hMqz2OsJA2IhLu7rfP09AFMqhYZFMUwaIH1P/mz/hL8843mA8aAqC
 y9ddI1ei3yYVMrb26nKInapSYVlJSwvBX3V8zOWOVXMwhxjKtm0sXVjV8dhMMDpGXmZj
 ih5w==
X-Gm-Message-State: AOJu0YwyZdX0MkQfjPEUEQxIIO2t+n5dYOZWxApQKhCSyZoKT6ABSfQN
 Lq5o5bf3cranuSVgEjeW10R4zdZNbStainTyFhgmBn9d1yb+JIA0inrmTZBek7Y=
X-Gm-Gg: ASbGncsNsE4NDP2h6JpBH0hE8zJMjh3Ps4BDW+YgyivYR6FUfdtceJpLXSuGdrCgYKs
 f/HnB4+M6DP8rvE1Ecws9cy3lOOzkbmEtFHvtn2b2UCkbKtpGsoagXIGF5ml2wNjBU+UknNtUmr
 ldHYDn5f9hpAXf3mYxi6X6OCFf+K658M7lRULk3Zq2kiFuJTk4NRPYO9FP7656lRyCOUZ9wZq5U
 3culnOqufoCq1F8k+zOKpgM/u2ewEJJUtZI4ELu42U3hRPz
X-Google-Smtp-Source: AGHT+IFm6ff9mXjpNEaSfptCFvykhHZe/hvru3gPBMS9Sp+Xiu1qWbegK4T8Ju3vW7Kev7jjun8FdA==
X-Received: by 2002:a05:6512:3c8c:b0:53d:db99:c79e with SMTP id
 2adb3069b0e04-53ddb99e8cdmr4260469e87.3.1732548376583; 
 Mon, 25 Nov 2024 07:26:16 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45bdbabsm194746775e9.18.2024.11.25.07.26.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:26:14 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 861D7620B7;
 Mon, 25 Nov 2024 15:21:07 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 19/28] tests/functional: Convert the Avocado aarch64 tuxrun
 tests
Date: Mon, 25 Nov 2024 15:20:56 +0000
Message-Id: <20241125152105.2100395-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move the tests to a new file so that they can be run via
qemu-system-aarch64 in the functional framework.

Since these were the last tests in tests/avocado/tuxrun_baselines.py,
we can now remove that file, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20241121165806.476008-20-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index acc7405aed..eb7149bf1a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -994,6 +994,7 @@ F: hw/arm/virt*
 F: include/hw/arm/virt.h
 F: docs/system/arm/virt.rst
 F: tests/functional/test_aarch64_virt.py
+F: tests/functional/test_aarch64_tuxrun.py
 F: tests/functional/test_arm_tuxrun.py
 
 Xilinx Zynq
@@ -4129,7 +4130,7 @@ F: scripts/ci/
 F: tests/docker/
 F: tests/vm/
 F: tests/lcitool/
-F: tests/avocado/tuxrun_baselines.py
+F: tests/functional/test_*_tuxrun.py
 F: scripts/archive-source.sh
 F: docs/devel/testing.rst
 W: https://gitlab.com/qemu-project/qemu/pipelines
diff --git a/tests/avocado/tuxrun_baselines.py b/tests/avocado/tuxrun_baselines.py
deleted file mode 100644
index 38064840da..0000000000
--- a/tests/avocado/tuxrun_baselines.py
+++ /dev/null
@@ -1,224 +0,0 @@
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
-    def test_arm64(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=machine:virt
-        :avocado: tags=tuxboot:arm64
-        :avocado: tags=console:ttyAMA0
-        :avocado: tags=shutdown:nowait
-        """
-        sums = {"Image" :
-                "ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7",
-                "rootfs.ext4.zst" :
-                "bbd5ed4b9c7d3f4ca19ba71a323a843c6b585e880115df3b7765769dbd9dd061"}
-        self.common_tuxrun(csums=sums)
-
-    def test_arm64be(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=cpu:cortex-a57
-        :avocado: tags=endian:big
-        :avocado: tags=machine:virt
-        :avocado: tags=tuxboot:arm64be
-        :avocado: tags=console:ttyAMA0
-        :avocado: tags=shutdown:nowait
-        """
-        sums = { "Image" :
-                 "e0df4425eb2cd9ea9a283e808037f805641c65d8fcecc8f6407d8f4f339561b4",
-                 "rootfs.ext4.zst" :
-                 "e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7"}
-        self.common_tuxrun(csums=sums)
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 758145d1e5..923f9e7078 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -14,6 +14,7 @@ test_timeouts = {
   'aarch64_raspi4' : 480,
   'aarch64_sbsaref_alpine' : 720,
   'aarch64_sbsaref_freebsd' : 720,
+  'aarch64_tuxrun' : 240,
   'aarch64_virt' : 720,
   'acpi_bits' : 420,
   'arm_aspeed' : 600,
@@ -52,6 +53,7 @@ tests_aarch64_system_thorough = [
   'aarch64_sbsaref',
   'aarch64_sbsaref_alpine',
   'aarch64_sbsaref_freebsd',
+  'aarch64_tuxrun',
   'aarch64_virt',
   'multiprocess',
 ]
diff --git a/tests/functional/test_aarch64_tuxrun.py b/tests/functional/test_aarch64_tuxrun.py
new file mode 100755
index 0000000000..da56aee4ed
--- /dev/null
+++ b/tests/functional/test_aarch64_tuxrun.py
@@ -0,0 +1,50 @@
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
+from qemu_test import Asset
+from qemu_test.tuxruntest import TuxRunBaselineTest
+
+class TuxRunAarch64Test(TuxRunBaselineTest):
+
+    ASSET_ARM64_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/arm64/Image',
+        'ce95a7101a5fecebe0fe630deee6bd97b32ba41bc8754090e9ad8961ea8674c7')
+    ASSET_ARM64_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/arm64/rootfs.ext4.zst',
+        'bbd5ed4b9c7d3f4ca19ba71a323a843c6b585e880115df3b7765769dbd9dd061')
+
+    def test_arm64(self):
+        self.set_machine('virt')
+        self.cpu='cortex-a57'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_ARM64_KERNEL,
+                           rootfs_asset=self.ASSET_ARM64_ROOTFS)
+
+    ASSET_ARM64BE_KERNEL = Asset(
+        'https://storage.tuxboot.com/20230331/arm64be/Image',
+        'e0df4425eb2cd9ea9a283e808037f805641c65d8fcecc8f6407d8f4f339561b4')
+    ASSET_ARM64BE_ROOTFS = Asset(
+        'https://storage.tuxboot.com/20230331/arm64be/rootfs.ext4.zst',
+        'e6ffd8813c8a335bc15728f2835f90539c84be7f8f5f691a8b01451b47fb4bd7')
+
+    def test_arm64be(self):
+        self.set_machine('virt')
+        self.cpu='cortex-a57'
+        self.console='ttyAMA0'
+        self.wait_for_shutdown=False
+        self.common_tuxrun(kernel_asset=self.ASSET_ARM64BE_KERNEL,
+                           rootfs_asset=self.ASSET_ARM64BE_ROOTFS)
+
+if __name__ == '__main__':
+    TuxRunBaselineTest.main()
-- 
2.39.5


