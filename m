Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213EBC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:56:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr26y-0003FT-VW; Sat, 08 Mar 2025 16:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26w-0003Dx-Kq
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:34 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26u-0000uB-1Y
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:34 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso2661275e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470810; x=1742075610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L0IWx7DP2oaeVZU3zQdeb+u9JDC8B6jtkTZn3wjhUEU=;
 b=mYtmL9FnnU0M43spd51Xjo1kOlECf+WtdBYPwt2Pyj3vqhiej6XTprbN2kWc4ygVfl
 ALyD/5tMy1Hhif3vzyHIn+HoHX+u2bNCVHB19DB+/9VX0/13XYjv18/GTwleqVuhX+8x
 UYnr71dUQizbJbOJBAvmBJTblMSbOlRHqotbgxYjiFHb637Vrys7eDQtIq9aTaL/2ho2
 vtw75qiIzIuQllkk//fO+1VUBf1MSvpZK7/QxNjyM0Idzmvbv7AZshKRBSBBvd3thVg8
 JM+IH4rU4EQwV+Wd5h3qgva1RkQur0GCDRjgV0Zh0my/q1g9Q3sIcgNxtemYFLZm/Bp3
 ItUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470810; x=1742075610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L0IWx7DP2oaeVZU3zQdeb+u9JDC8B6jtkTZn3wjhUEU=;
 b=xIGUXvMxhERhiWwVP2lkixBsPe0N7fP3R9A9Smf4zWHgaTGCI0YWpm9m4DclN/EMqo
 0NPWCKcpLLGF61ZW3cnr/vKGtwHh8wiYk8MnXIZ/H+xEEufnN0H4cynC3MqzAgyMJAtL
 EraamnTh/ZqkmJyrByvJ9I0aMEBLldnhd9z4deot/YEoEJ5ME2BQSG2UQKl2dyWvEj0v
 xB5PlwTqCo0xkT2edLBDx4aqW87Cy7jdLNIj7gY7zcHHFoXB0WTFdVzDLCaKNrdLNvQU
 BJs8kT/Hxwy7MHypI1OkRZM6ZcqN8u48zLnTmHhxZLUe97IpRti2m3DWl8cWuTHBIjap
 JUwA==
X-Gm-Message-State: AOJu0YzKdQO15GT/6YhYQ/BQM+KF9ZMc/MXrbPWWMcwVT1EhGmyhpoG5
 ZEGc1Cy+0K5LNohNRvtJE744WoykrKvPMTkjlkBYtjhDpdZgGFB+eOm96TEsgYk=
X-Gm-Gg: ASbGncvGW51dUJgnrGlybTWMsxMWrAP3lVahlFYXZOz71QVeg5MbfA9XkoQFuK2crEx
 yG1xEN+ro31qMHc8xjJd9NPEvbuMZ+FinxfObDJlhRDkUv9zI5bRz/UMmbjcPRJhS/0qt2ZtMo8
 CgtspwtRbNCt/zkP2ly47QNMd748ekHefpZFB89G2jQO0GehmokgV00uwz2/nEgL443fJVeQC7W
 F24YEVFdpAnPhVGxU1h4FgHeY9yZ1LKwkv8ksd8pgchi4n8HtkQaw5naj/Ir4MENYR21DQX9bjm
 hslj0bO97QF7+wixze/8DIAwDiHax9t2puRKMQUl6KTKYZM=
X-Google-Smtp-Source: AGHT+IEwHzxm2aPr7rRfVwm/Y4qd/aXDg04sBaF7YNdN6lmHWh0Wmmkn1Yg1SO19qRiu7Cjxjqj3wg==
X-Received: by 2002:a05:600c:4ec6:b0:43b:c0fa:f9c5 with SMTP id
 5b1f17b1804b1-43c6024bf6bmr47735765e9.21.1741470810078; 
 Sat, 08 Mar 2025 13:53:30 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c01952dsm9757036f8f.45.2025.03.08.13.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:27 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A73275FA05;
 Sat,  8 Mar 2025 21:53:26 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 01/31] tests/functional: move aarch64 GPU test into own file
Date: Sat,  8 Mar 2025 21:52:56 +0000
Message-Id: <20250308215326.2907828-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

I want to expand the number of tests to cover a wide range of
configurations. That starts with splitting off from the normal virt
test from which it doesn't really share much code. We can also reduce
the timeout of the original virt test now it is now longer burdened
with testing the GPU.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-2-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 5df6020ed5..756432add4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2630,6 +2630,7 @@ F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
 F: docs/system/devices/virtio-gpu.rst
+F: tests/functional/test_aarch64_virt_gpu.py
 
 vhost-user-blk
 M: Raphael Norwitz <raphael@enfabrica.net>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 3fd2652c07..4b492135e0 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -18,7 +18,8 @@ test_timeouts = {
   'aarch64_sbsaref_alpine' : 1200,
   'aarch64_sbsaref_freebsd' : 720,
   'aarch64_tuxrun' : 240,
-  'aarch64_virt' : 720,
+  'aarch64_virt' : 360,
+  'aarch64_virt_gpu' : 480,
   'acpi_bits' : 420,
   'arm_aspeed_palmetto' : 120,
   'arm_aspeed_romulus' : 120,
@@ -81,6 +82,7 @@ tests_aarch64_system_thorough = [
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
index 0000000000..32af941cd5
--- /dev/null
+++ b/tests/functional/test_aarch64_virt_gpu.py
@@ -0,0 +1,94 @@
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
+from qemu.machine.machine import VMLaunchFailure
+
+from qemu_test import Asset
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
+from qemu_test import skipIfMissingCommands
+
+from qemu_test.linuxkernel import LinuxKernelTest
+
+class Aarch64VirtGPUMachine(LinuxKernelTest):
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
+    LinuxKernelTest.main()
-- 
2.39.5


