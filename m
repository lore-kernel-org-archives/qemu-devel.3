Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 614A6FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 12:58:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHLUI-0006nS-Bi; Mon, 27 Apr 2026 08:55:00 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLSj-0004O0-Lh
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:53:29 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHLNV-0005VV-GM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 08:48:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso102132225e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 05:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777294073; x=1777898873; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lrmjgu0DENSyxUCVcnWjBPDdGhFkQDou3KySNjf2DPs=;
 b=UFujMHWqb1AeHwXmf+VuUusgfJXvLsrR7/UYacnpBjbV+5jL3LDonKC3wrqUG1Jttf
 pWu5qtiAhnnVMIfnsn05G8PF2XzW/UfF/BqpUAQpSsf6q+D6kfzt3aztkFylcC1Ui2IS
 j9SwT7uqq6EepnY6lgRvWnbrRAhsQoWJJ5VxswWAwnIu32YAIh4PQQ3NkX6NBTcKQYlP
 RNF355VvuNTVjw8fXQdGdnLz4KHbI6qtIbqxPF9T+++GZDzyJG6yNOSfla7yBEVFUMZI
 Bm4hdcVFxPwN72uiHD+79Fwf0o6xKa8p0dOSv2Tvl3NNkFtpVjjfwdghKvOK475ni8fo
 R1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777294073; x=1777898873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lrmjgu0DENSyxUCVcnWjBPDdGhFkQDou3KySNjf2DPs=;
 b=Cj7BMJHxJP68kAh7Ys4q6G4jaLea03J4l7JTCnvolWCyWPSrvu1CwOxaaQTVIfhU8/
 yAb8H/Q+Iypz3ev7M8WRsDyPPLfJgzBLNCd5tHrMrXNA9RZ75x05meWwA8FJeHrGxXp/
 ESy/YhsX9nLlxjpOtBbDLecw1h26seyAsQ5VKGtCHzDSml47U4Tei0RELYoRTEHKaoK/
 0jzKZ67JX1XPxXlpRocVNf7TDIvekYu3bN/fC/frpQKE+z3BZgClB4p0Q6wauzhtnxvC
 EKGJgg3ezbTmRn89shlBP6WMw3rERSKhsfcvPOcVgFz7nALlufstAyToMc3OzRJUnmYq
 DWdg==
X-Gm-Message-State: AOJu0Yx3Oz5gT0WE+z7kkg+u6tiLVe24GJtSWF+fVVJoQKBZTPTxrcHM
 DhFIz8b9QDppbSSxJCs8oCaj0/pNOOzHNEoSfh52ChaE8Gvmp6NLRRtIgk893rov3pBQ6wsBDdL
 iVNnW
X-Gm-Gg: AeBDievo4PZ53HofLCaEasECNNatUuUaVq3J/TvZZlaw7FP3XiH0wEO2NUuRqMl7j+P
 myHndJQ7bEiAmC/es5vblRJ7UhD5qBdUnevt7ahCsA0hcV+d8sOWqvw7Np8i4heQZW9lSQvvIWk
 l+bUm1Ue7WnSJ2i8eyQXlFKFW971ySnVpWy0yqODcnYJxWhiZf9U1Z4ZtXbc/1FVLexqakT57M6
 KtYv+Xxn/b27pywTuzcp242UWS05vyGLTpJQOgm01idOn+ndqrTzRUrcqRmpltllhpFx+QKfQTu
 tLUzJa24Rx9TWfIkBozl5CrJ2TUZz2SpA8MnBRARCDvjn0uL3umm/ib33/Q47NRLQTfHLj2qMjU
 ATgraUTyGWFzAlLTP49lbEiQRn0IY14Vs0NGmbV+Kr9tjp/aiUF7raPYUmMn/YGOu1/rt366o24
 0A5D0MXr+YJaqiT4e1kcuR7wt8g7pn8a4IR0Anui1XCISUXcpigmbufeKB0epM9rtM+MnhW+qX+
 C639lAtddqtraMnI5TQMBw0ggitnHHVrzeGqiLfUMxORHejqcZZ
X-Received: by 2002:a05:600c:8183:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-488fb765ab5mr610879845e9.14.1777294072970; 
 Mon, 27 Apr 2026 05:47:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffc5e3f4sm448974115e9.2.2026.04.27.05.47.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 05:47:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/63] hw/arm/fsl-imx8mm: Adding functional testing of iMX8MM
 emulation
Date: Mon, 27 Apr 2026 13:46:50 +0100
Message-ID: <20260427124738.966578-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427124738.966578-1-peter.maydell@linaro.org>
References: <20260427124738.966578-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Gaurav Sharma <gaurav.sharma_7@nxp.com>

Added script that would validate the iMX8MM emulation by checking the
linux console log. If it succeeds, it will return:-

ok 1 test_imx8mm_evk.Imx8mmEvkMachine.test_aarch64_imx8mm_evk_usdhc

Signed-off-by: Gaurav Sharma <gaurav.sharma_7@nxp.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
[PMM: Add missing blank lines that flake8 wants]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                                 |  1 +
 tests/functional/aarch64/meson.build        |  2 +
 tests/functional/aarch64/test_imx8mm_evk.py | 69 +++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100755 tests/functional/aarch64/test_imx8mm_evk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 8167d42876..8d980d6c40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -921,6 +921,7 @@ F: hw/arm/fsl-imx8mm.c
 F: hw/arm/imx8mm-evk.c
 F: include/hw/arm/fsl-imx8mm.h
 F: docs/system/arm/imx8m.rst
+F: tests/functional/aarch64/test_imx8mm_evk.py
 
 MCIMX8MP-EVK / i.MX8MP
 M: Bernhard Beschow <shentey@gmail.com>
diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 7ea8c22b04..1067f181f2 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -5,6 +5,7 @@ test_aarch64_timeouts = {
   'aspeed_ast2700a2' : 600,
   'aspeed_ast2700fc' : 600,
   'device_passthrough' : 720,
+  'imx8mm_evk' : 240,
   'imx8mp_evk' : 240,
   'raspi4' : 480,
   'reverse_debug' : 180,
@@ -29,6 +30,7 @@ tests_aarch64_system_thorough = [
   'aspeed_ast2700fc',
   'device_passthrough',
   'hotplug_pci',
+  'imx8mm_evk',
   'imx8mp_evk',
   'kvm',
   'multiprocess',
diff --git a/tests/functional/aarch64/test_imx8mm_evk.py b/tests/functional/aarch64/test_imx8mm_evk.py
new file mode 100755
index 0000000000..86725991f1
--- /dev/null
+++ b/tests/functional/aarch64/test_imx8mm_evk.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
+
+class Imx8mmEvkMachine(LinuxKernelTest):
+
+    ASSET_IMAGE = Asset(
+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
+         'debian-12-generic-arm64-20231210-1590.tar.xz'),
+        '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
+
+    KERNEL_OFFSET = 0x51000000
+    KERNEL_SIZE = 32622528
+    INITRD_OFFSET = 0x76000000
+    INITRD_SIZE = 30987766
+    DTB_OFFSET = 0x64DB5000
+    DTB_SIZE = 36812
+
+    def extract(self, in_path, out_path, offset, size):
+        try:
+            with open(in_path, "rb") as source:
+                source.seek(offset)
+                data = source.read(size)
+            with open(out_path, "wb") as target:
+                target.write(data)
+        except (IOError, ValueError) as e:
+            self.log.error(f"Failed to extract {out_path}: {e}")
+            raise
+
+    def setUp(self):
+        super().setUp()
+
+        self.image_path = self.scratch_file("disk.raw")
+        self.kernel_path = self.scratch_file("linux")
+        self.initrd_path = self.scratch_file("initrd.zstd")
+        self.dtb_path = self.scratch_file("imx8mm-evk.dtb")
+
+        self.archive_extract(self.ASSET_IMAGE)
+        self.extract(self.image_path, self.kernel_path,
+                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
+        self.extract(self.image_path, self.initrd_path,
+                     self.INITRD_OFFSET, self.INITRD_SIZE)
+        self.extract(self.image_path, self.dtb_path,
+                     self.DTB_OFFSET, self.DTB_SIZE)
+
+    def test_aarch64_imx8mm_evk_usdhc(self):
+        self.require_accelerator("tcg")
+        self.set_machine('imx8mm-evk')
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-m', '2G',
+                         '-smp', '4',
+                         '-kernel', self.kernel_path,
+                         '-initrd', self.initrd_path,
+                         '-dtb', self.dtb_path,
+                         '-append', 'root=/dev/mmcblk2p1',
+                         '-drive', f'file={self.image_path},if=sd,bus=2,'
+                                    'format=raw,id=mmcblk2,snapshot=on')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Welcome to ')
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.43.0


