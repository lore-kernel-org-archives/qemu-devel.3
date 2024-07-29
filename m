Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2F9C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 15:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYSIJ-00040z-4O; Mon, 29 Jul 2024 11:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIH-0003nm-1c
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:13 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYSIC-0008Lf-P6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 11:28:12 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4281e3b2f72so7836545e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 08:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722266886; x=1722871686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FkWKuKtm3cf9wl2kIVdOE8LPsOxAfVlikpttFpluek=;
 b=pR5LumrKB6DUpO1ZfueszxyHEV5s7YmbX5xmSKWJtIeCXErxIdH63oAZpthyaB/gfU
 IMlafb0uxfqYmlLCgaGTKC8YWiT+EatLzpAw3IF5q3lMxjQ0xSgpVdPdh/JDc2sMRdO3
 PMrBQUsVOmamYAqtz/cBgdBZ3M6inS07LL0aRu7mGjd9KVYmmyDVWyuSGTPoa2r4f8SG
 H1eV3ng8PsY80HixaS1oKMpuEL47V9H2eMNlJysRHp/ScihBOy/PnCWXDoIrRKQ6qDvb
 ZBE92Xg8IH5dTY/LryEvpwwcIk04TfbNgE7c0WFUZTFK46ng85DqIsjxP0HwVFJX3FEF
 SXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722266886; x=1722871686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+FkWKuKtm3cf9wl2kIVdOE8LPsOxAfVlikpttFpluek=;
 b=kvlXWn9OFJZZ1CeDxfn58QcOtdQpuG/bHNJxCBwmVS4jni4+nS7qUG55ewrlABooKp
 juFINIe8KRSgSYbBxGYrTuArlbMSuS27bGjVmnyZ+MGFFKbwV6yEe3QXLZd5/rBX9SKq
 GYG8tO63Fk9SXDJwl9S6R68ZZ6VOungaziJL+NQ5FJetzpzfLRxW+7eznrJUdH1cwwlA
 kIhIppecnQ++sa2YUSCJklhpaCJYK2qQv3bi5Ql1ST9coWXEE06OwPG+76fT/WqghFmw
 uW18SL39Xd/RpLvyHgjh1Az7pow54vKXBVodhk09BLOWw3zRXyhJTSvqkh3peC1p0ehf
 5UEQ==
X-Gm-Message-State: AOJu0YwcRmPK+mJLr2LokoZE3pPTQb0eMmTYH1WxOBzZEMCqyOU1CAv1
 YT8qQxDVvaV6FAIUFFck2GdTM65S9GSGx6Js4JZfF13veCEVP0LZP3TP+F1715d3/JBlG4MsdJ0
 q
X-Google-Smtp-Source: AGHT+IG3utXQ56ShFApIxHTbPaZn7LlNXXRwk3Ne9dl7Oo0gCaIHLoYknh0SuR+XI3QPe5EwtG1V4Q==
X-Received: by 2002:a05:600c:4f8e:b0:428:2e9:65a9 with SMTP id
 5b1f17b1804b1-42811dd1024mr48417305e9.28.1722266885912; 
 Mon, 29 Jul 2024 08:28:05 -0700 (PDT)
Received: from localhost.localdomain ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280f484cdesm118324465e9.44.2024.07.29.08.28.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Jul 2024 08:28:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/14] tests/functional: Convert avocado tests that just need a
 small adjustment
Date: Mon, 29 Jul 2024 17:27:08 +0200
Message-ID: <20240729152714.10225-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240729152714.10225-1-philmd@linaro.org>
References: <20240729152714.10225-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Thomas Huth <thuth@redhat.com>

These simple tests can be converted to stand-alone tests quite easily,
e.g. by just setting the machine to 'none' now manually or by adding
"-cpu" command line parameters, since we don't support the corresponding
avocado tags in the new python test framework.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240724175248.1389201-7-thuth@redhat.com>
[PMD: More uses of set_machine(), updated MAINTAINERS]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                                   |  3 +
 tests/functional/meson.build                  |  6 ++
 .../test_info_usernet.py}                     | 11 ++-
 .../test_ppc_74xx.py}                         | 74 ++++++++-----------
 .../version.py => functional/test_version.py} | 13 ++--
 5 files changed, 56 insertions(+), 51 deletions(-)
 rename tests/{avocado/info_usernet.py => functional/test_info_usernet.py} (87%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
 mode change 100644 => 100755
 rename tests/{avocado/version.py => functional/test_version.py} (78%)
 mode change 100644 => 100755

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d84803b69..4c9a36dfd3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -317,6 +317,7 @@ F: configs/devices/ppc*
 F: docs/system/ppc/embedded.rst
 F: docs/system/target-ppc.rst
 F: tests/tcg/ppc*/*
+F: tests/functional/test_ppc_74xx.py
 
 RISC-V TCG CPUs
 M: Palmer Dabbelt <palmer@dabbelt.com>
@@ -2105,6 +2106,7 @@ S: Odd Fixes
 F: hw/net/
 F: include/hw/net/
 F: tests/qtest/virtio-net-test.c
+F: tests/avocado/info_usernet.py
 F: docs/virtio-net-failover.rst
 T: git https://github.com/jasowang/qemu.git net
 
@@ -2974,6 +2976,7 @@ S: Supported
 F: include/qemu/option.h
 F: tests/unit/test-keyval.c
 F: tests/unit/test-qemu-opts.c
+F: tests/functional/test_version.py
 F: util/keyval.c
 F: util/qemu-option.c
 
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index a8cc0e6330..8a8fa0ab99 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -15,6 +15,12 @@ test_timeouts = {
 
 tests_generic = [
   'empty_cpu_model',
+  'info_usernet',
+  'version',
+]
+
+tests_ppc_quick = [
+  'ppc_74xx',
 ]
 
 tests_x86_64_quick = [
diff --git a/tests/avocado/info_usernet.py b/tests/functional/test_info_usernet.py
old mode 100644
new mode 100755
similarity index 87%
rename from tests/avocado/info_usernet.py
rename to tests/functional/test_info_usernet.py
index e1aa7a6e0a..cd37524d94
--- a/tests/avocado/info_usernet.py
+++ b/tests/functional/test_info_usernet.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Test for the hmp command "info usernet"
 #
 # Copyright (c) 2021 Red Hat, Inc.
@@ -8,18 +10,16 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 
 from qemu.utils import get_info_usernet_hostfwd_port
 
 
 class InfoUsernet(QemuSystemTest):
-    """
-    :avocado: tags=machine:none
-    """
 
     def test_hostfwd(self):
         self.require_netdev('user')
+        self.set_machine('none')
         self.vm.add_args('-netdev', 'user,id=vnet,hostfwd=:127.0.0.1:0-:22')
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
@@ -31,3 +31,6 @@ def test_hostfwd(self):
         self.assertGreater(port, 0,
                            ('Found a redirected port that is not greater than'
                             ' zero'))
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/ppc_74xx.py b/tests/functional/test_ppc_74xx.py
old mode 100644
new mode 100755
similarity index 74%
rename from tests/avocado/ppc_74xx.py
rename to tests/functional/test_ppc_74xx.py
index f54757c243..5386016f26
--- a/tests/avocado/ppc_74xx.py
+++ b/tests/functional/test_ppc_74xx.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Smoke tests for 74xx cpus (aka G4).
 #
 # Copyright (c) 2021, IBM Corp.
@@ -5,132 +7,120 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later.  See the COPYING file in the top-level directory.
 
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
 
 class ppc74xxCpu(QemuSystemTest):
-    """
-    :avocado: tags=arch:ppc
-    :avocado: tags=accel:tcg
-    """
+
     timeout = 5
 
     def test_ppc_7400(self):
-        """
-        :avocado: tags=cpu:7400
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7400')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7410(self):
-        """
-        :avocado: tags=cpu:7410
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7410')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,74xx')
 
     def test_ppc_7441(self):
-        """
-        :avocado: tags=cpu:7441
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7441')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7445(self):
-        """
-        :avocado: tags=cpu:7445
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7445')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7447(self):
-        """
-        :avocado: tags=cpu:7447
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7447')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7447a(self):
-        """
-        :avocado: tags=cpu:7447a
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7447a')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7448(self):
-        """
-        :avocado: tags=cpu:7448
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7448')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,MPC86xx')
 
     def test_ppc_7450(self):
-        """
-        :avocado: tags=cpu:7450
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7450')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7451(self):
-        """
-        :avocado: tags=cpu:7451
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7451')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7455(self):
-        """
-        :avocado: tags=cpu:7455
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7455')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7457(self):
-        """
-        :avocado: tags=cpu:7457
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7457')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
 
     def test_ppc_7457a(self):
-        """
-        :avocado: tags=cpu:7457a
-        """
         self.require_accelerator("tcg")
+        self.set_machine('g3beige')
         self.vm.set_console()
+        self.vm.add_args('-cpu', '7457a')
         self.vm.launch()
         wait_for_console_pattern(self, '>> OpenBIOS')
         wait_for_console_pattern(self, '>> CPU type PowerPC,G4')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/avocado/version.py b/tests/functional/test_version.py
old mode 100644
new mode 100755
similarity index 78%
rename from tests/avocado/version.py
rename to tests/functional/test_version.py
index c6139568a1..3ab3b67f7e
--- a/tests/avocado/version.py
+++ b/tests/functional/test_version.py
@@ -1,3 +1,5 @@
+#!/usr/bin/env python3
+#
 # Version check example test
 #
 # Copyright (c) 2018 Red Hat, Inc.
@@ -9,17 +11,18 @@
 # later.  See the COPYING file in the top-level directory.
 
 
-from avocado_qemu import QemuSystemTest
+from qemu_test import QemuSystemTest
 
 
 class Version(QemuSystemTest):
-    """
-    :avocado: tags=quick
-    :avocado: tags=machine:none
-    """
+
     def test_qmp_human_info_version(self):
+        self.set_machine('none')
         self.vm.add_args('-nodefaults')
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
                           command_line='info version')
         self.assertRegex(res, r'^(\d+\.\d+\.\d)')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.45.2


