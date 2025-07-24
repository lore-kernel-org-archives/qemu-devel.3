Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73254C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 09:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uesT3-0002Ca-Ko; Thu, 24 Jul 2025 05:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uesT1-000297-AY
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 05:42:23 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uesSx-0006lT-UN
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 05:42:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45618ddd62fso8216065e9.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 02:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753350136; x=1753954936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m+IjG+CRjaKatMyTbAgaxzfHSRUlW1Vf8eZ7rtdqBRw=;
 b=spROvAEILVpjJQTgKq+pDzLTvLfasF4LBX3+jWOzv/N23i29S5yu27CqcecVwlnxDv
 ZW4MePHPAXLUF7dD6o0O0Mudh1AymBclAA6o/U6I4aXgG6kO4pot4E0vNb03EUU403Bs
 eIbXxsU0CBo5CFaenV+UOlzPk7XYjjeHcdYEnV5OCyWGoC1BQ6jhe42wcGBWO+UaBEyN
 HimYIUuGZEXA0/x5zepwmEh+KgnpW98XqMvDZ6tkVCLD8uRLCsPT2pdb7KUXu79YC/WI
 eJiCKpVTiaZz2MjybLGQ69PABBmINTBR+GXxwIJYoPpbZaSLe6f8nUfaBzrKC1JZz5Ov
 37cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753350136; x=1753954936;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m+IjG+CRjaKatMyTbAgaxzfHSRUlW1Vf8eZ7rtdqBRw=;
 b=jxOW0NN6ls+u6jG8UgqPiFpO+vgJm0NuVAam4LPyc2Lx/ccxVbIMMteVzyO8VYNCda
 LoKaj0iX7XjV1Uj+aJsbDqM4eeuRRlDotUscAxMsTN141H3ZKBhLP0Vos9S+jOHCVSh6
 2uFN+CWgqXQBCuvfRLPAi9SvSPUjr/5+Tncd23/JZ1ihlVF79VVNTJQME82zxhEcxTPJ
 X2JDSbQAo8mgpOf0ceWkgVbths9tlBKXQi6uWgzX6WtGsIKnLhVJhV32O4Ci10aXY9R4
 XOdfT0VWbERZ7H0GBOYU3lr+qtKUeA4Ll3KywNWoMGPULD9y3g6VJnV2cZhw9B+3tLzI
 bQzg==
X-Gm-Message-State: AOJu0Yzvj8ff1GWLhLQzPTTLKXX9KtovJVJY6Js07Y/ZrXMFcXuxB2h8
 e4n3jtw/HoJ7TS6zEbBRAqgF6yoDyE/VgIlOd01JwfUoReUFcENVO830KJ7yHKa4KxbxsL8ZA90
 //jKK
X-Gm-Gg: ASbGncuUorTwYvqvwV9MfJfNr8dBVhGYH+FrS0FXY/x4f+Dpaee+njP8ltfLYj9+KUq
 mXpkM4R3zvCuiv8GJycMNV+6xPu10hy0DouJye4/DtotaNRpE5Xq1gqmcUe2avRL4sjVA9D6co0
 I3RO4xfYL1IuL6UjecoWOuQwdCYhi7kVZYymP5IPvL1tHnPVenNPNxYuhQcvz1B9eTwcadoIQtz
 fAd8kl9zeP8iiMrQVPMaGt3L7TIS8QfJHBSUf0EMQjqxmDK3DfQ/RCDtOYtJjjVGKad2zX9K6k4
 rnxaOhD8dvovhZgZTVpuE6VYSZyLNghte54qx4XXrdGL1zWuLLWDV87/3jfZBXfdFRAI6VooTQD
 OVEHVDp3JAtg7Dn13BylphXG3d7wtiknZXBX2AeSpktsQ0mBl1R/JN7KwyrKFEyT7IIDK5aot
X-Google-Smtp-Source: AGHT+IHWUYburSzVbprQxj5q78FjM1k7dBj/K7UKTmI1xCJLVmAUxWRw54duk6Y2N+EspeStI/p00A==
X-Received: by 2002:a05:6000:1ac6:b0:3a4:f8e9:cef2 with SMTP id
 ffacd0b85a97d-3b768f1e40cmr4669106f8f.36.1753350136317; 
 Thu, 24 Jul 2025 02:42:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b76fcad291sm1580809f8f.50.2025.07.24.02.42.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Jul 2025 02:42:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Burton <mburton@qti.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] tests/functional: add hypervisor test for aarch64
Date: Thu, 24 Jul 2025 11:42:14 +0200
Message-ID: <20250724094214.93330-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

This is a simple test case that runs an image with kvmtool and
kvm-unit-tests which can validate virtualisation works. This is useful
for exercising TCG but can also be applied to any nested virt setup
which is why it doesn't specify an accelerator.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250721153326.783646-1-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v2: Addressed Manos review comments
---
 tests/functional/meson.build         |  1 +
 tests/functional/test_aarch64_kvm.py | 80 ++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+)
 create mode 100755 tests/functional/test_aarch64_kvm.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 7699af9e2d2..2f7bc4ed65c 100644
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
index 00000000000..add89c58c5e
--- /dev/null
+++ b/tests/functional/test_aarch64_kvm.py
@@ -0,0 +1,80 @@
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
+    KUT_BASE = '/usr/share/kvm-unit-tests/'
+
+    def _launch_guest(self, kvm_mode):
+
+        self.set_machine('virt')
+        kernel_path = self.ASSET_KVM_TEST_KERNEL.fetch()
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               f'console=ttyAMA0 kvm-arm.mode={kvm_mode}')
+
+        self.vm.add_args('-accel', 'tcg')
+        self.vm.add_args('-cpu', 'cortex-a72')
+        self.vm.add_args('-machine', 'virt,gic-version=3,virtualization=on',
+                         '-kernel', kernel_path,
+                         '-append', kernel_command_line)
+        self.vm.add_args('-smp', '2', '-m', '320')
+
+        try:
+            self.vm.launch()
+        except VMLaunchFailure as excp:
+            self.log.info('unhandled launch failure: %s', excp.output)
+            raise excp
+
+        self.wait_for_console_pattern('buildroot login:')
+        ec_and_wait(self, 'root', '#')
+        ec_and_wait(self, f'export PS1="{self.PS1}"', self.OK_CMD)
+
+    def _run_kut(self, kvm_mode):
+        ec_and_wait(self, f'{self.KUT_BASE}/selftest-setup', self.OK_CMD)
+        ec_and_wait(self, f'{self.KUT_BASE}/selftest-vectors-kernel', self.OK_CMD)
+        ec_and_wait(self, f'{self.KUT_BASE}/selftest-vectors-user', self.OK_CMD)
+        ec_and_wait(self, f'{self.KUT_BASE}/selftest-smp', self.OK_CMD)
+
+    def do_test(self, kvm_mode='nvhe', accel='tcg'):
+        self.require_accelerator(accel)
+        self._launch_guest(kvm_mode)
+        self._run_kut(kvm_mode)
+
+    def test_aarch64_vhe_selftest_tcg(self):
+        self.do_test('vhe')
+
+    def test_aarch64_nvhe_selftest_tcg(self):
+        self.do_test('nvhe')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.49.0


