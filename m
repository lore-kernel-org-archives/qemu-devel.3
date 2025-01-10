Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96978E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:23:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEzO-00007W-A8; Fri, 10 Jan 2025 08:23:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz4-0008LM-IP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:32 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEyz-0005bA-Fd
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:28 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-aaeef97ff02so346749266b.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515403; x=1737120203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5DJG8+d3aMQ+E3l97FmHYegwzpk8yW/iphynWGtRxqs=;
 b=eHoJw8Ol7JJQaeJDmcPCfz1baNHdUnQS2YCKajzXm5RAQSUrXNLUKQVI66AE3ckl/N
 wDq2MCKUERTO8fOYWrCq4uHttPICq5UKuD3Q3T5TRE/jFniNjw0jhrdHol+oK0KANrCa
 IVLKys+5QACXDtU7pN6jr7awuvxvbDeVkMbdQrRtvRyNBa4kQF0Dq2Bm6Q+220BuW644
 mJmbLRg4x83ZcWWOBaKbPKHVqKxpCpUFbaAcNwgnfhpyToUn0jwlPrCuPQOK+8beM8ay
 BFHSP1FliXAJLZWiLcIL/N5tnESNlDqyTO76HJyf89eJjzBvjz8EyWophJnj9ROw4BXg
 bUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515403; x=1737120203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5DJG8+d3aMQ+E3l97FmHYegwzpk8yW/iphynWGtRxqs=;
 b=GkmNPNwrYZa0nXQmm07gqGhldVeGXqjQKUHu3lae5LZv66LGcBhbowULGFAYsdqibW
 G8HsuQ9M7eGQRU85ZfxexkyhKh0zOfUyx/O2t3at2Hkarsqokt5ubk2xK4Rm/Dq9rT/v
 KCz5t75oU++4RDg9/tRkKWwm02aCQ1K6ws5iSjqS++6A2xjEzonzTIsN8nXlZ2qCGd2v
 UTKY4qMSFEq3FwkLquboBBOKMRzYOPDoLr4PX+rl6I3a3KzWX/Or2oiKFcYXARMGkzmu
 oA+5VK6Z4bfwdscwENI1ZfCjNJwmwunLUITkEZaO/TuAxaqzGhoXhrpxyaZS0I/OfQM2
 5cwQ==
X-Gm-Message-State: AOJu0YwWbsKpDzhAbzeTlQDcFX50gPCANKbR4CEt3GdapRBr8bHbjqe3
 RyNNAn8I6hPVPQvC3CS6zu9KUafkfQ4ec6WOuXGxgzaHaqnv0U899ZVcWWg+PJY=
X-Gm-Gg: ASbGncs50kUJmSGa/gnt6zrg/QsOEGcGEV08IiD43zZoE4y1nIETJa9gZ0MSYowRBV4
 AbDYVGvzrJ0fT/fT7Jg91elmRN9gxaFlC+kIjPWyOtoyu4TdDYtzoA8MEGaZVLofR6x0Yu9XNMN
 Mqzv3SmUzGLyrXozRiQ9cDYWBFHzzR/e6HOLi2uLQ/pj4uyGBu0Wq0abzItYEduUWnjCAkeUt6w
 S8ej3kJfcAE84I/3cDZEFE5H3beaKK+kaWn9Dtdhhmq8W2BKSH7RHU=
X-Google-Smtp-Source: AGHT+IGUPswcaU7EByCj1mYv6NWHnQ8UKtr5X2QJO6Zvy/+YphvlDga3kJkEQDx0uoUxa6Rd9mHdsQ==
X-Received: by 2002:a17:906:fe0c:b0:aab:75f1:e51a with SMTP id
 a640c23a62f3a-ab2abc78dc8mr977404766b.38.1736515403230; 
 Fri, 10 Jan 2025 05:23:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dacd7sm166529066b.70.2025.01.10.05.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 244E26159E;
 Fri, 10 Jan 2025 13:17:56 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:Virt)
Subject: [PULL 23/32] tests/functional: extend test_aarch64_virt with vulkan
 test
Date: Fri, 10 Jan 2025 13:17:45 +0000
Message-Id: <20250110131754.2769814-24-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Now that we have virtio-gpu Vulkan support, let's add a test for it.
Currently this is using images build by buildroot:

  https://lists.buildroot.org/pipermail/buildroot/2024-December/768196.html

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-24-alex.bennee@linaro.org>

diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
index 201c5ed023..6b2336a28d 100755
--- a/tests/functional/test_aarch64_virt.py
+++ b/tests/functional/test_aarch64_virt.py
@@ -13,10 +13,12 @@
 import logging
 from subprocess import check_call, DEVNULL
 
+from qemu.machine.machine import VMLaunchFailure
+
 from qemu_test import QemuSystemTest, Asset
-from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
 from qemu_test import wait_for_console_pattern
-from qemu_test import get_qemu_img
+from qemu_test import skipIfMissingCommands, get_qemu_img
 
 
 class Aarch64VirtMachine(QemuSystemTest):
@@ -132,5 +134,73 @@ def test_aarch64_virt_gicv2(self):
         self.common_aarch64_virt("virt,gic-version=2")
 
 
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
+    def test_aarch64_virt_with_gpu(self):
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
+            else:
+                self.log.info("unhandled launch failure: {excp.output}")
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
+
 if __name__ == '__main__':
     QemuSystemTest.main()
-- 
2.39.5


