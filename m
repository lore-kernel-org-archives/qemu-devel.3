Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C8BC87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwoy-000220-RX; Sun, 27 Jul 2025 04:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwob-0001Rz-S8
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:05 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoZ-0000Bn-KP
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:05 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ae3b336e936so687901866b.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605182; x=1754209982; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lv063VARif1A14hlZGWwamkKdjeXZOTuTRh5eNUvFJw=;
 b=XjTaHTsdCRteU+CaNJgvkVAVVwI6s6TJLTz9OSP4WvBXCS1JPaM1N2ad3sw+c2gdq7
 s/XaFGKhIiJAiqi6V1iGGTMyhsr7fKCg46WJuIxSvomg4TBMRUAjp6PQ33/VGEwHKrmj
 vYfYw3jM+8xDaYw0lUqF17QMgnP2QN7mRP1feOvXBXXQgR8zlg2XRElMx5dUMqUofp5U
 hXH77uxI+o8l5GRXPeinDRBXUn0XcFA8xALqEygMuj7L4ft/A3PWg/mJZIrwDgG4hmeP
 +nVZi4mEMaK40Jmcnb8DZlmIwCILhn7wOaQK+jTaFT4xMnqjiPKcNGyPtrLBzg+m1J7X
 dqQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605182; x=1754209982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lv063VARif1A14hlZGWwamkKdjeXZOTuTRh5eNUvFJw=;
 b=uEtMGqqv61c1x2RJeoher7GodmLaILxlmdpEG3+JPdADtF1ocN+XClH9BUqgZDO2k2
 H9i7rgX3oCNApytGtW3uC0Js2LCCCerAaa/HfmpgRLBIcuG3QXoAcw/MM/StbVX37JCL
 EVJ1IMqru8eBzcW1GHDUrmw1zDJQ/NhxreMRpvH+KbQyN9yxwWCFGeBYh6uxKR6a3upH
 4zrSWcKKDRdocj4th0PvasWBxCOSbyQ5cUchtVX+3Hb3SosTZoPspbpXmOqjojRhfgT8
 88BwkyiHNiHPFEt38swBNiSsms6mpcYmtGZKCITXgiiM71cNwJEg72Qb2G58MfC5V24j
 73Nw==
X-Gm-Message-State: AOJu0Yzna5tJqpqFen7A4opwjglPpXxvhB5k1wbQhJ5qzCo3fIjuKwYU
 W9oNR+FODtoiOKWyTuZmcMm9ftgmDYHNxqPlSecdYzIyps99d2xPV1EzkLstyhi07po=
X-Gm-Gg: ASbGncuK33IdWznDEjbz2+CYNrS8LLhwjA/EEUK5qcRQrpmLmChXf3wzl351m4Z+sEJ
 dJ/xh+I4uy1c4KHnyLNviDL9djXhrEgBqtdJlnNlnVVh7qYhR8ckfrLY2pWJ0XscMHuYKaacyDg
 FtDJo7hehnCKS+4FP2WSg9yPhqimq7JxCQj4cwU3V+FVwj8Evxc3TWV6QfcdvbdzerGFbwrwiaQ
 Yb/Ul6AIHFrWvIbzdrau9BLJlfZXE0lmMjTRm1/n5RsHkqODqbRy3Z8QyMtwp4h8QVJoLXpKJFA
 pVY0sZ6IF+OlktYSjkSFydWQWXBJXqwvHFx/vcm0ylVUfSOdVMrrucEOXXGoD2GwuLUjiex/hpD
 Bx9+lTCzAbD+tE02E9l84OWM=
X-Google-Smtp-Source: AGHT+IGxwAY+z91br875WvTPBwHh/2qGfoqppPt/cSDxLH11p4dOg/aH4XxCj1U2sqh8hhydHHwImA==
X-Received: by 2002:a17:906:d552:b0:ae1:f1e0:8730 with SMTP id
 a640c23a62f3a-af61ec115d1mr994925266b.57.1753605182030; 
 Sun, 27 Jul 2025 01:33:02 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af63585ff65sm258509366b.29.2025.07.27.01.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:32:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9BD155F8C8;
 Sun, 27 Jul 2025 09:32:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 06/14] tests/functional: add hypervisor test for aarch64
Date: Sun, 27 Jul 2025 09:32:45 +0100
Message-ID: <20250727083254.3826585-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
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

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-7-alex.bennee@linaro.org>

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


