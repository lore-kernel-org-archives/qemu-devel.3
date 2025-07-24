Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4789DC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:03:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetg1-0007S0-8b; Thu, 24 Jul 2025 06:59:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfx-0007Km-HJ
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:49 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uetfv-0007xw-In
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 06:59:49 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aec46b50f33so135079166b.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 03:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753354786; x=1753959586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBRZ04wX0MzyglrriRi9JfcL05p9dBe8tgATnNn/jvk=;
 b=bWZ+ePKJ7OnoycxUjuY9mUdu0WKir8VAeo47v+EXl8APugFRQ1FTTuQ9kDZSwttGfZ
 EMGkmHaSYBk0mTY/MP/5v2k/MgREn90nYE57J9K9uPc/biqYZOwO0t4HXfaalkesJWiU
 +oO4D4fDZXGx57Jzv694sr8tq9j50gB517pYJjGm2K4OVe171ZXoRonqboAQEFhOVphH
 gfLk/frI8S6m5ZXO4K65NmgDC0AK9Fugh4eqSQL16V8HIn4sFyVEtdZtfmsuPEmMI9cK
 A9yV04vU54qlIFVJAUWMlYYmTmUSN6cH3q1O2sW5PPDueaFGkDO67hZwn36kS//1/Pqp
 /pSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753354786; x=1753959586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBRZ04wX0MzyglrriRi9JfcL05p9dBe8tgATnNn/jvk=;
 b=qfw54Hr18/2RuaTgGzawmN+YKAWfCUivGa+us3EX1fa9NV0BhK4RwhQEVqOLqYm2WQ
 kT09cSJbexPETA0HRyDEOMtcRXHr5zJkfvQN8JiyRTh1zB6SHa7OjvVYyui9HaMpltVa
 jAVngRUmDtyDJFi4CA6z8cXXWJf5s8Ix6Ne6SX8vacgy4VjcZjJLoZDdgZl2RKp60i4c
 ltQsWTaYewHdAuK7CEfLLTlBG+cXOR0jsCNnfVDB6fX/IBdM4cb2A1Z2bezEGbP+S9EK
 ZmpGyipMqQJ0emo7fR8ppLE1GyEsvFPpM6eRg61Gkeo5tuZzOZ6djnkIKWYb9Xy+4e0g
 pxyw==
X-Gm-Message-State: AOJu0Yw/FEudI7q3Z1Lroj9M/WaafCOlWtKQnnZyqEZuMk+6NU05Usrv
 VyENXy2W9gRme2Z/xOZ/B7DvmZKdBZ91VvJh65fUc33C9/ixy2+qYiO9zsXCvNjI7O0=
X-Gm-Gg: ASbGncsWDU4iC68j7Vq1d6JgLOxh0yLh3RfiT7rY7tobVyEgriAFWQ1epv5zmkjP8zc
 if/FNnzAuFtWFZBDqoI+r7GzSFB6EjnlIyapv0OYs8nALR+3nVpwmOp3xx0NmHya/QmzOxh0vxa
 +78Hhgd6rG8qOAm7SDAW/te6SnTZdryCGI+pZdDcqNoyIdhZgMcwsrtqHN6x6DKMDHJxVA6gEs6
 IA7j14BHW2syiWbULkANGRBSSdE4f7IdEanWTPG3F+u7jmFHGAPULJa0hRJgN9FCncNxFdvSC1U
 om0e6sLIcibeYBiuFDhnlZCPZkarEnG7QwWb7TiYnosgXzlI8HcsPyjxab1iTJHjEYPcANIuD9+
 sJ0t6GWqU+tZotb5bk41en0g=
X-Google-Smtp-Source: AGHT+IGqxbHC6uIJXmpyz6M8zxfyL+GuF0lDTGbv2ideeluG8Qaqj9/yIpaiply8YrlEBS6gnc/lZQ==
X-Received: by 2002:a17:907:7209:b0:ae6:c561:764a with SMTP id
 a640c23a62f3a-af2f66c20a2mr630420466b.2.1753354785620; 
 Thu, 24 Jul 2025 03:59:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af47cc6e841sm96783466b.52.2025.07.24.03.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 03:59:44 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 753635F8C8;
 Thu, 24 Jul 2025 11:59:40 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Mark Burton <mburton@qti.qualcomm.com>
Subject: [PATCH for 10.1 06/13] tests/functional: add hypervisor test for
 aarch64
Date: Thu, 24 Jul 2025 11:59:32 +0100
Message-ID: <20250724105939.2393230-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250724105939.2393230-1-alex.bennee@linaro.org>
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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


