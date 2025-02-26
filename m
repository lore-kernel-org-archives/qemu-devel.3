Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F16E5C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnI14-00018O-1v; Wed, 26 Feb 2025 09:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0x-0000xT-1r
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:55 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tnI0t-0005f3-Fm
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:03:54 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43984e9cc90so5747355e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740578628; x=1741183428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D2cgi/gDJAyPqliWmZWtNiNSMuYoxc6Sw7E/720Aads=;
 b=qhhsqelbsQ7vgFQJf4tBGoRydRj3X3WiCAiMW1dfd8cDkQqkFQNzWfm6HtdmniF18G
 47KCIdxIBURyOfBHbasvKWqn74U3IAVoHTNOxX4JWR5+42p/XY0b4svBagwtiQXZWut3
 h3DVoIXiiJWKrctN8oN5ouBXm6TQFAvc/sMEJVoCoHDYDggKrTofHOmmMSSvDs8wT9TV
 T06K2K8tnBl4xiymZcIZ0aBlYNGOBdwBZSNQdKKiDdl60oEuJEBTECEQU3IFv3LiAoMe
 4E7vFQfrxzHag65HSy4GAjhAIjjamrVstRasDDGR6A/OSeE3VCMIgpWrybDX6E+ogCee
 2/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740578628; x=1741183428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D2cgi/gDJAyPqliWmZWtNiNSMuYoxc6Sw7E/720Aads=;
 b=NViFffUm/eAk5J/EvE1W8UzTkLjh87UIWOjkIQW8xMIoVvZabODH5xARmSLLHbcpwa
 EmhtqdgSYf0EnyrmLXuj6/+lUois3L9Fb1ymShypuLLY8hNa+jcGOEPFzX5jR5CbDtrH
 59N0Bkkxc58DaIAbjfFSMC7QFYdPkEzwDv4+NxSrMLcnXcAPiqLUqPukLdtS9e6Wfk90
 61Nbhg4o1KAR1Tb/r78NtdGJTtBew49GZPht32xlQuJ5V3qKlzRQN5nN4Io8u5CuOOcv
 DZlSW0pIer6/BeUEh5zCVRPsW/vjJcn4QrAMfwnQ/NICQrZxGKQNdDjt4fx5S6YtgXYF
 //RA==
X-Gm-Message-State: AOJu0YzmyMKlTQLQP0WOOCKYSUBrx3SrbJeCa30jDjMUqo0mM/0wNW2l
 mhMvIaFS7HnEdQlyBhaD1KsguycxxTdwU8I8FSzs0n3eL7yU6PfgWkSedDaUa8I=
X-Gm-Gg: ASbGncvHla3APvcQ4VUt50wGP74D6NPckQDVSofl4f1IDA9I5GPzLPcjXpGJYpX9x8d
 9btphPe1E3aJkZTlaEtvziEtSxyYyg6FLZWdu8A/Tg5S8No06Bj8s4eeuzy48kw0mqp2QLugV3P
 jk1KDWdt8xoaozgBoInxOvJR9gq3tWJ60k+n+prRWTeUHsNQ3zwkLy1mii9IYsrhfNLe3RZ0jxs
 IKM2cxwr3UbOaURHU91hN0jognVAKuyJSe1JbhD9eABQ0ps8xUHaVfajnstjMUpFPHc5JazYJrJ
 ME4Ow/VotBHBM3CyrbUS8I4bxwnt
X-Google-Smtp-Source: AGHT+IGFsLK/hFAPn1zqwr4ISTdZRk3h18q0YpTJjvHty+enDz8zcVwgpCGzsMqcJMwRgyHwfNDR+Q==
X-Received: by 2002:a5d:6486:0:b0:38d:dffc:c14f with SMTP id
 ffacd0b85a97d-38f6149915fmr19889328f8f.1.1740578627978; 
 Wed, 26 Feb 2025 06:03:47 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba543f21sm22895015e9.28.2025.02.26.06.03.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:03:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 039B05F949;
 Wed, 26 Feb 2025 14:03:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Kyle Evans <kevans@freebsd.org>,
 Eduardo Habkost <eduardo@habkost.net>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 01/25] tests/functional: move aarch64 GPU test into own file
Date: Wed, 26 Feb 2025 14:03:19 +0000
Message-Id: <20250226140343.3907080-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226140343.3907080-1-alex.bennee@linaro.org>
References: <20250226140343.3907080-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

I want to expand the number of tests to cover a wide range of
configurations. That starts with splitting off from the normal virt
test from which it doesn't really share much code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250219150009.1662688-2-alex.bennee@linaro.org>
---
 tests/functional/meson.build              |   2 +
 tests/functional/test_aarch64_virt.py     |  71 ---------------
 tests/functional/test_aarch64_virt_gpu.py | 102 ++++++++++++++++++++++
 3 files changed, 104 insertions(+), 71 deletions(-)
 create mode 100755 tests/functional/test_aarch64_virt_gpu.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 111d8bab26..c12ee1ce41 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -19,6 +19,7 @@ test_timeouts = {
   'aarch64_sbsaref_freebsd' : 720,
   'aarch64_tuxrun' : 240,
   'aarch64_virt' : 720,
+  'aarch64_virt_gpu' : 720,
   'acpi_bits' : 420,
   'arm_aspeed_palmetto' : 120,
   'arm_aspeed_romulus' : 120,
@@ -78,6 +79,7 @@ tests_aarch64_system_thorough = [
   'aarch64_tcg_plugins',
   'aarch64_tuxrun',
   'aarch64_virt',
+  'aarch64_virt_gpu',
   'aarch64_xen',
   'aarch64_xlnx_versal',
   'multiprocess',
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 95f5ce8b4c..884aad7af6 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -134,77 +134,6 @@ def test_aarch64_virt_gicv2(self):
         self.common_aarch64_virt("virt,gic-version=2")
 
 
-    ASSET_VIRT_GPU_KERNEL = Asset(
-        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
-        'download?path=%2F&files='
-        'Image',
-        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
-
-    ASSET_VIRT_GPU_ROOTFS = Asset(
-        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
-        'download?path=%2F&files='
-        'rootfs.ext4.zstd',
-        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
-
-    @skipIfMissingCommands('zstd')
-    def test_aarch64_virt_with_gpu(self):
-        # This tests boots with a buildroot test image that contains
-        # vkmark and other GPU exercising tools. We run a headless
-        # weston that nevertheless still exercises the virtio-gpu
-        # backend.
-
-        self.set_machine('virt')
-        self.require_accelerator("tcg")
-
-        kernel_path = self.ASSET_VIRT_GPU_KERNEL.fetch()
-        image_path = self.uncompress(self.ASSET_VIRT_GPU_ROOTFS, format="zstd")
-
-        self.vm.set_console()
-        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'console=ttyAMA0 root=/dev/vda')
-
-        self.vm.add_args("-accel", "tcg")
-        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
-        self.vm.add_args("-machine", "virt,gic-version=max",
-                         '-kernel', kernel_path,
-                         '-append', kernel_command_line)
-        self.vm.add_args("-smp", "2", "-m", "2048")
-        self.vm.add_args("-device",
-                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
-        self.vm.add_args("-display", "egl-headless")
-        self.vm.add_args("-display", "dbus,gl=on")
-        self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
-        self.vm.add_args("-blockdev",
-                         "driver=raw,file.driver=file,"
-                         "node-name=hd0,read-only=on,"
-                         f"file.filename={image_path}")
-        self.vm.add_args("-snapshot")
-
-        try:
-            self.vm.launch()
-        except VMLaunchFailure as excp:
-            if "old virglrenderer, blob resources unsupported" in excp.output:
-                self.skipTest("No blob support for virtio-gpu")
-            elif "old virglrenderer, venus unsupported" in excp.output:
-                self.skipTest("No venus support for virtio-gpu")
-            elif "egl: no drm render node available" in excp.output:
-                self.skipTest("Can't access host DRM render node")
-            elif "'type' does not accept value 'egl-headless'" in excp.output:
-                self.skipTest("egl-headless support is not available")
-            else:
-                self.log.info(f"unhandled launch failure: {excp.output}")
-                raise excp
-
-        self.wait_for_console_pattern('buildroot login:')
-        exec_command(self, 'root')
-        exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
-        exec_command_and_wait_for_pattern(self,
-                                          "weston -B headless "
-                                          "--renderer gl "
-                                          "--shell kiosk "
-                                          "-- vkmark -b:duration=1.0",
-                                          "vkmark Score")
-
 
 if __name__ == '__main__':
     QemuSystemTest.main()
diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/test_aarch64_virt_gpu.py
new file mode 100755
index 0000000000..f21ae18392
--- /dev/null
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -0,0 +1,102 @@
+#!/usr/bin/env python3
+#
+# Functional tests for the various graphics modes we can support.
+#
+# Copyright (c) 2024, 2025 Linaro Ltd.
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import logging
+
+from qemu.machine.machine import VMLaunchFailure
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+from qemu_test import skipIfMissingCommands
+
+class Aarch64VirtGPUMachine(QemuSystemTest):
+    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
+    timeout = 360
+
+    def wait_for_console_pattern(self, success_message, vm=None):
+        wait_for_console_pattern(self, success_message,
+                                 failure_message='Kernel panic - not syncing',
+                                 vm=vm)
+
+    ASSET_VIRT_GPU_KERNEL = Asset(
+        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
+        'download?path=%2F&files='
+        'Image',
+        '89e5099d26166204cc5ca4bb6d1a11b92c217e1f82ec67e3ba363d09157462f6')
+
+    ASSET_VIRT_GPU_ROOTFS = Asset(
+        'https://fileserver.linaro.org/s/ce5jXBFinPxtEdx/'
+        'download?path=%2F&files='
+        'rootfs.ext4.zstd',
+        '792da7573f5dc2913ddb7c638151d4a6b2d028a4cb2afb38add513c1924bdad4')
+
+    @skipIfMissingCommands('zstd')
+    def test_aarch64_virt_with_vulkan_gpu(self):
+        # This tests boots with a buildroot test image that contains
+        # vkmark and other GPU exercising tools. We run a headless
+        # weston that nevertheless still exercises the virtio-gpu
+        # backend.
+
+        self.set_machine('virt')
+        self.require_accelerator("tcg")
+
+        kernel_path = self.ASSET_VIRT_GPU_KERNEL.fetch()
+        image_path = self.uncompress(self.ASSET_VIRT_GPU_ROOTFS, format="zstd")
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'console=ttyAMA0 root=/dev/vda')
+
+        self.vm.add_args("-accel", "tcg")
+        self.vm.add_args("-cpu", "neoverse-v1,pauth-impdef=on")
+        self.vm.add_args("-machine", "virt,gic-version=max",
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.add_args("-smp", "2", "-m", "2048")
+        self.vm.add_args("-device",
+                         "virtio-gpu-gl-pci,hostmem=4G,blob=on,venus=on")
+        self.vm.add_args("-display", "egl-headless")
+        self.vm.add_args("-display", "dbus,gl=on")
+        self.vm.add_args("-device", "virtio-blk-device,drive=hd0")
+        self.vm.add_args("-blockdev",
+                         "driver=raw,file.driver=file,"
+                         "node-name=hd0,read-only=on,"
+                         f"file.filename={image_path}")
+        self.vm.add_args("-snapshot")
+
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            if "old virglrenderer, blob resources unsupported" in excp.output:
+                self.skipTest("No blob support for virtio-gpu")
+            elif "old virglrenderer, venus unsupported" in excp.output:
+                self.skipTest("No venus support for virtio-gpu")
+            elif "egl: no drm render node available" in excp.output:
+                self.skipTest("Can't access host DRM render node")
+            elif "'type' does not accept value 'egl-headless'" in excp.output:
+                self.skipTest("egl-headless support is not available")
+            else:
+                self.log.info(f"unhandled launch failure: {excp.output}")
+                raise excp
+
+        self.wait_for_console_pattern('buildroot login:')
+        exec_command(self, 'root')
+        exec_command(self, 'export XDG_RUNTIME_DIR=/tmp')
+        exec_command_and_wait_for_pattern(self,
+                                          "weston -B headless "
+                                          "--renderer gl "
+                                          "--shell kiosk "
+                                          "-- vkmark -b:duration=1.0",
+                                          "vkmark Score")
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.39.5


