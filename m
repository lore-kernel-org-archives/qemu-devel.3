Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F19C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 15:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufKcd-0003m6-AO; Fri, 25 Jul 2025 11:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKc0-0003Ap-A3
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:38 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufKbx-0002Sp-NY
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 11:45:31 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aec46b50f33so373807966b.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 08:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753458327; x=1754063127; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bwGqdtmYsXLYT4cV4+QQFBwWc6jmgZWJKPKsBEeRTIs=;
 b=TH3hFbELr4n+7AQLmQLsaY2kyAYhTiw9i7csJOwSCrds50nAjVKM1nsfpisblTKK2b
 All8hnw/l/fy+BgI/CEWUgctfZy6Grk32MfnPAa0HMNGd48RUSxPpPs9pA0iJAmN/Ud9
 lD0NFA1dSrdxLfgE2CnomoNgg7UW6Kr4c4IKW81Z/BBp6BWQm+GL4YOGY/DmmbfuvIn5
 Tf2QjPa0XeQmOTH4t1CuqMvrHRcGWA5fXFH2C2jQf3p5+nna8tBOHP3tf68lGqY8Zt7R
 FWCNQ7p63G+G0JGqYNOl0ynHERZL5MEnhBBNaPkoTO5PSmL1Q+brZ+OPMrvYYmBW++44
 +4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753458327; x=1754063127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwGqdtmYsXLYT4cV4+QQFBwWc6jmgZWJKPKsBEeRTIs=;
 b=slyfpc5R5R+ib3ed6TEP5L1JHY7wrc9+52+SIINlqsE8LniOKI1ok33+EQw8UiFuN6
 wTP1EiKXXXoEPIXrOmpC2VVkhr9RcOu4i2lE5VaVrmfjbi1vGbdsjrLAUgttjLVnPSDu
 KpIt6FhXafoSti9Bf6W33Xl/G3D5KrCi7+wUh8U6UMyiBA2wP5T8YZ7h854IdlU8hKI7
 0BSimAnVfjwNH9JsEX8WrTPj2MoPqyPMzj8Np9m8wj2mO9jPKvPBJRh1jphB6WFEjUQt
 3nnkL1IhQ6yR51fxDKuYgHVJDPuRjt8i2smeyjiohktSkHt+lGxsOuEPUhh/OkR1lkpk
 bHug==
X-Gm-Message-State: AOJu0YyxT6AkQ/zCUdlnGu9gg3WseNIhdC0AKzkyS/qpnuM8ux/49QKB
 ZYC+u9dR1+5EXAUlY7PGM6rPpA3MVkhbvgM4ToSp0A5zgyzGU01YIH31UWZxLJ9fG50=
X-Gm-Gg: ASbGncuAqO6/9BMJKlyW/w/pQbG9K9aG/VKJTMyekY5CIIrvNjZ4H9c4aqCKJD15Z0h
 rqw4KOyAmcZCuDi6PfZ3BmUZ8Nwu3znj03MttTktvSD1FFwl8fPRtYUfsRn1jJ56TEvzBTwuzgx
 Dq81YQttB4YbvsQYZ2NxcFfSf27alrp4BMbF7ORS/hWJQpXPV0GqVbj29Xg3phoXVwXL0mnBDFs
 faAi3Y2bNsU2GXBts2hFe5g100mH2NVE6eaj4MjmhQspNwhroJh+BNT+sAACn/wAW602q7HagLz
 mdCDblpgKLAFYTuEUiWe+a5k14uJoVkJe0bzP1XmBH09eIvcfb63CvVmUWPBEtuPp4YZqGC5VkF
 Q0gSVdq+pSTsrvxDtzVsplVA=
X-Google-Smtp-Source: AGHT+IGH/j4Werq+MEgIWqHqiB5MTEi57pEdhOgnZjC9MMATq6Me31VN4TbWyOxcDy7PlB9vGyA94g==
X-Received: by 2002:a17:907:3da8:b0:ae3:60e5:ece3 with SMTP id
 a640c23a62f3a-af616d056e8mr294306266b.6.1753458327190; 
 Fri, 25 Jul 2025 08:45:27 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af635a61103sm8582966b.70.2025.07.25.08.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 08:45:23 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5DB4B5F8C8;
 Fri, 25 Jul 2025 16:45:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH for 10.1 v2 06/14] tests/functional: add hypervisor test for
 aarch64
Date: Fri, 25 Jul 2025 16:45:09 +0100
Message-ID: <20250725154517.3523095-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725154517.3523095-1-alex.bennee@linaro.org>
References: <20250725154517.3523095-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - drop try/except (copy paste from gpu handling)
  - refactor tests into helper, add commentary
  - drop 2 line spacing
---
 tests/functional/meson.build         |  1 +
 tests/functional/test_aarch64_kvm.py | 71 ++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)
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
index 00000000000..9fb9286139f
--- /dev/null
+++ b/tests/functional/test_aarch64_kvm.py
@@ -0,0 +1,71 @@
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
+        self.vm.launch()
+
+        self.wait_for_console_pattern('buildroot login:')
+        ec_and_wait(self, 'root', '#')
+        ec_and_wait(self, f"export PS1='{self.PS1}'", self.OK_CMD)
+
+    # this is just a smoketest, we don't run all the tests in the image
+    def _smoketest_kvm(self):
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-setup", self.OK_CMD)
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-smp", self.OK_CMD)
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-kernel", self.OK_CMD)
+        ec_and_wait(self, f"{self.KUT_BASE}/selftest-vectors-user", self.OK_CMD)
+
+    def test_aarch64_nvhe_selftest(self):
+        self._launch_guest("nvhe")
+        self._smoketest_kvm()
+
+    def test_aarch64_vhe_selftest(self):
+        self._launch_guest("vhe")
+        self._smoketest_kvm()
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.2


