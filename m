Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49541C282E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpaiN-0006Wc-9B; Tue, 04 Mar 2025 17:26:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagz-0005NB-Hu
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:49 -0500
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpagx-0006UR-0E
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:49 -0500
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5e4f88ea298so7976110a12.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127085; x=1741731885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axgWtiOkGGmP9jd5CQ2re9gHdvRfWCbPTPi2wsUSA58=;
 b=dhnGWLLQbGIzOxQrOw83CLA2CcSX5avf3XWN9UQJbDgGiE7A9w2RMCoAySV0j7VfuD
 gZaO5MrHCscIWneOVPRE2U5CD6GkxmFRZ0153AAiylmogYv3MOKI4D006txsXgIWEPgr
 W+qlgOp/5XRqZq8eicrv1zXdIX/Dd5Uz+uYVxjoekBtXwdMqcR2QrmlAj9IJ40esgM+Z
 X1qVk6KBujWmCkxDVeO4temALdlxuISaRu7KVBERxVX4LNmmH2pBGk40WvpLZoX2q4qm
 BlFXYk7PSuPZw1RkkdQNHynWcJfOESkWHY0lolJjkdf01zflRhFVJdVadhqWLvrr96w1
 fNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127085; x=1741731885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axgWtiOkGGmP9jd5CQ2re9gHdvRfWCbPTPi2wsUSA58=;
 b=ejDKwtFKstL7GG3BS7KOiLwlaLNJ1pEQCrYVpxgDljo89TXWyRKE4csJupy8QZV/Pt
 h9RX5nkh70Qk4vmncJ1wzjTXoZ/0M/3X8Fp68oPeB+esy7mQtPkQNS3MeLMvhTSGeIQg
 tdKw87WP6w8IJQiOaBxFq9Z18bqu1ogfYOn34Df9WktF6tjXfVzVjdgQEu7wTQIL9mUU
 BWPN5Ss2CPHXsnscRiQARRslDVPZ028N04Aq8EWbPueIwy57z+2SBaZ+c8ku9JOCC1rh
 xw9a0XtcMdrk1xHG8ICJWl123djhpTMHpfOg6wC6VCb4hQqux2dLeg2d58syNsoydDiE
 /inA==
X-Gm-Message-State: AOJu0YwbQZPE4CUfzgr7x7JQHbVaTcnfL6lHXvEgb8oOZZl85mi+Ugu8
 JVeh3iGpFG3ImLT8tnVxff71H/pwdHUTS/FGQnOXhMPTt6mUnCyTSrficlqi3nE=
X-Gm-Gg: ASbGncvRSVqWoNDnDYHvfhPBhBnwLYrEl2nt/rPh2Eff7iIekYL2+epFVVqWBxp9dWz
 bEd+A/4l7pmU4JwslKGZfxGNxFnYldIv1C6y++avUOwnYEV9eEt6M8KzMGvwFHppTSHxlSJAldU
 KuYR42P/Iwixn8u4I0l3lSb5/o4xv21olvhtCqROP5p59Fz2mcw6+Awx/uRfqFg3esYUsjEVgPL
 YJx8wa9oKx49caXucCvyYTr9YfNwFIjFR76qoDySVlFRSle6xjR/Ym8TicTMBgNpS4PeEkaJbbp
 LFoLB9WPGFE+cG1F1VunxOoQewLSdxCfSV9WAd0P6SS0pEE=
X-Google-Smtp-Source: AGHT+IGbXcRZpX+PdIcBI15Nf5jpccdOyBOWHkQoPIvuAq+UZxNsDwPJvDb3oeCkpheHySENqg3eyA==
X-Received: by 2002:a05:6402:1e8c:b0:5d9:fc81:e197 with SMTP id
 4fb4d7f45d1cf-5e59f3c2304mr608100a12.8.1741127085220; 
 Tue, 04 Mar 2025 14:24:45 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b6cfdcsm8831363a12.29.2025.03.04.14.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:41 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7D9585FBC3;
 Tue,  4 Mar 2025 22:24:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 01/32] tests/functional: move aarch64 GPU test into own file
Date: Tue,  4 Mar 2025 22:24:08 +0000
Message-Id: <20250304222439.2035603-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x533.google.com
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
test from which it doesn't really share much code. We can also reduce
the timeout of the original virt test now it is now longer burdened
with testing the GPU.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250219150009.1662688-2-alex.bennee@linaro.org>

---
v2
  - drop unused logging import
  - inheriting LinuxKernelTest for wait_for_console_pattern
  - lower the virt timeout to 360, use 480 for gpu test
---
 tests/functional/meson.build              |  4 +-
 tests/functional/test_aarch64_virt.py     | 71 -----------------
 tests/functional/test_aarch64_virt_gpu.py | 94 +++++++++++++++++++++++
 3 files changed, 97 insertions(+), 72 deletions(-)
 create mode 100755 tests/functional/test_aarch64_virt_gpu.py

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
index 0000000000..616e6ed656
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
+from qemu_test import QemuSystemTest, Asset
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
+    QemuSystemTest.main()
-- 
2.39.5


