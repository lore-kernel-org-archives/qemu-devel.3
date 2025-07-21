Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD8CC83F25
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 15:34:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udsWZ-0006G4-Ut; Mon, 21 Jul 2025 11:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1udsWL-00067f-WC
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:33:48 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1udsWJ-0000bI-JE
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 11:33:41 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so49245965e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 08:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753112018; x=1753716818; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kBRZ04wX0MzyglrriRi9JfcL05p9dBe8tgATnNn/jvk=;
 b=tw8KiagWI+HWNFp8snSMfTZzDDgGOZ0/NW+QsWDmTjkOWv8jFhLjWAF+n4cV82lSOv
 rX6kN0tELGSMaYjVXzmEE8HRI9xlfQu4a23DEGdMe+p2CO7VaSetZoH6H/eyun0K7YDQ
 XvHiGiBvQx/ExAv+M+hc3OodUI0tcPDY29PqGviGc6E3rmy3wxTCUKY43t5x98eE1pNW
 n9Jwy+aMXC5io9xGfK2XkvlvLOzPSOTn2DmGg/KcQ2h9Q6uZnXWad6NM1b0kBcER8FXV
 u0ELOpTgb1mwpIW+xzWpKfS7ZIGysRU601dkn7w4KIjeLS+SDRsJ10/JaHrmPGm8Zs3k
 RBwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753112018; x=1753716818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kBRZ04wX0MzyglrriRi9JfcL05p9dBe8tgATnNn/jvk=;
 b=dLLfeYIJfyrAhZ0Vw5k//ZkbtOyqcLJg+MXrTiXpf5TTEK+jDfXcF+dhzan3i9fmI3
 bzRYIt1RROf/gO73DFUe49kIwTwPTzN2Bgj+m/Kom3qW6qmEmAOZAa7cGwND2dq/fAUz
 B42BdYKd6kWhQJuaodTFuB+Zhj4YcSPiNiCSfLmttDKfbEYlVZuS88m8hDGGhMfIT3zl
 enMzZLbpscMbUC4cHsLAYd7PpppT2jq24Kka5CsH281V7OuoW//7KXqxfW2keCVJD9st
 ZoMS4VquL2shThDKMdUzslg87Fx9LrIsnavMRby0q/Qg8IBusUPeQsK86AgxyXRxAPxu
 vhSA==
X-Gm-Message-State: AOJu0YwilWDsg4/Lz38GzlMlJEFrW1agfTKMVnNc9cMR0am0Au2xSAJV
 3TC9BHogQDVDMnR/IDp/xG66idtxl73MuWwe/OLFvdNDFWLOZtgZ5AOC3vjgbazdP/c=
X-Gm-Gg: ASbGncvmnjYYmV4PPLutmY/zaMVSaSSH0T20oPGa6wMRHpfIiBmJLP3PuPwgkCF465d
 W2uW8Btcw2stO5FD5nJ3zzNfscaALOiNizDRbTycTIht5BAAUlBmqDzXyoIC784LcZ7sPWS1kgw
 zxr8QflwxY2Jm2+ubhKVfz2YabcX7/6dIjRKNp+YD3W1cbT+02RXlRN+Q7cbBdo4h4jD2oihMFs
 OMHB8KzGUAbKmNibcF9fI0fjgACUDkMlBKlNfNpHc5VU0FWWdOfTv0Gn/LSL1coX4G0F7FW4Jxf
 ccBxJHYJlHm3fI8ST+hgscEA52d6mTaXB1idmA3i+000KUMoHlB837rDiYZtVO1QEd2IFlAwvSY
 MHnRTBRzkdSmJudnLmXRZg0w=
X-Google-Smtp-Source: AGHT+IFaxmdMhxno+1k1m2fGQzxJ/tgypKdqfIbnicj6OiFQefpCzxniahLSH/N8qz5kTF8ms/fV1g==
X-Received: by 2002:a05:600c:3ba2:b0:456:d1c:ef38 with SMTP id
 5b1f17b1804b1-457b94ab14fmr19067155e9.24.1753112017723; 
 Mon, 21 Jul 2025 08:33:37 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45627962384sm117403325e9.2.2025.07.21.08.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 08:33:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 426935F83D;
 Mon, 21 Jul 2025 16:33:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mark Burton <mburton@qti.qualcomm.com>
Subject: [RFC PATCH] tests/functional: add hypervisor test for aarch64
Date: Mon, 21 Jul 2025 16:33:26 +0100
Message-ID: <20250721153326.783646-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

This is a simple test case that runs an image with kvmtool and
kvm-unit-tests which can validate virtualisation works. This is useful
for exercising TCG but can also be applied to any nested virt setup
which is why it doesn't specify an accelerator.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Cc: Mark Burton <mburton@qti.qualcomm.com>
---
 tests/functional/meson.build         |  1 +
 tests/functional/test_aarch64_kvm.py | 83 ++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100755 tests/functional/test_aarch64_kvm.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 8bebcd4d94e..ecf965adc6c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -89,6 +89,7 @@ tests_aarch64_system_thorough = [
   'aarch64_device_passthrough',
   'aarch64_hotplug_pci',
   'aarch64_imx8mp_evk',
+  'aarch64_kvm',
   'aarch64_raspi3',
   'aarch64_raspi4',
   'aarch64_replay',
diff --git a/tests/functional/test_aarch64_kvm.py b/tests/functional/test_aarch64_kvm.py
new file mode 100755
index 00000000000..a42d82872af
--- /dev/null
+++ b/tests/functional/test_aarch64_kvm.py
@@ -0,0 +1,83 @@
+#!/usr/bin/env python3
+#
+# Functional test that runs subsets of kvm-unit-tests on Aarch64.
+# These can run on TCG and any accelerator supporting nested
+# virtualisation.
+#
+# Copyright (c) 2025 Linaro
+#
+# Author:
+#  Alex Bennée <alex.bennee@linaro.org>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu.machine.machine import VMLaunchFailure
+
+from qemu_test import Asset
+from qemu_test import exec_command_and_wait_for_pattern as ec_and_wait
+from qemu_test.linuxkernel import LinuxKernelTest
+
+
+class Aarch64VirtKVMTests(LinuxKernelTest):
+
+    ASSET_KVM_TEST_KERNEL = Asset(
+        'https://fileserver.linaro.org/s/HmjaxXXYHYSqbes/'
+        'download?path=%2F&files='
+        'image-with-kvm-tool-and-unit-tests.gz',
+        '34de4aaea90db5da42729e7d28b77f392c37a2f4da859f889a5234aaf0970696')
+
+    # make it easier to detect successful return to shell
+    PS1 = 'RES=[$?] # '
+    OK_CMD = 'RES=[0] # '
+
+    # base of tests
+    KUT_BASE = "/usr/share/kvm-unit-tests/"
+
+    def _launch_guest(self, kvm_mode="nvhe"):
+
+        self.set_machine('virt')
+        kernel_path = self.ASSET_KVM_TEST_KERNEL.fetch()
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               f"console=ttyAMA0 kvm-arm.mode={kvm_mode}")
+
+        self.vm.add_args("-cpu", "cortex-a72")
+        self.vm.add_args("-machine", "virt,gic-version=3,virtualization=on",
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.add_args("-smp", "2", "-m", "320")
+
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            self.log.info("unhandled launch failure: %s", excp.output)
+            raise excp
+
+        self.wait_for_console_pattern('buildroot login:')
+        ec_and_wait(self, 'root', '#')
+        ec_and_wait(self, f"export PS1='{self.PS1}'", self.OK_CMD)
+
+
+    def test_aarch64_nvhe_selftest(self):
+
+        self._launch_guest("nvhe")
+
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-setup", self.OK_CMD)
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-smp", self.OK_CMD)
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-kernel", self.OK_CMD)
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-user", self.OK_CMD)
+
+
+    def test_aarch64_vhe_selftest(self):
+
+        self._launch_guest("vhe")
+
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-setup", self.OK_CMD)
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-smp", self.OK_CMD)
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-kernel", self.OK_CMD)
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-user", self.OK_CMD)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.2


