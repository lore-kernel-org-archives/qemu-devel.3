Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E0FC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4a-0000yT-1C; Fri, 20 Jun 2025 18:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfch-000855-Lj
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfcf-0006gm-MY
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:33:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-450dd065828so15685975e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440832; x=1751045632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e45gg72CykCmOosOOuFqCWiWAfKi8lpY1H7Ol6ibhsw=;
 b=WCINInI6f0JMe9QcFQ90lHA2L2mOlAQAthSU/7zu4rfPP+Q62TGwInCP/N6PlKeZBc
 4s2gOG9aHreuk/KaJMZbkcx+NjHqLP3EUde2bO+Kfxz4UftTawLaLpvLj6mm1opeeZeX
 pcqJe979eGx1WTVNC/kzu9yCdiM/8V4Wm6atDOeNSxzTaO/dVQYuS+l8xe1xQPcKkteu
 pRHu5AzZPqQ+aEC7hQHZ5tt0YJ4A2wNHkLwJKiPLEfWCmG3s79xi5vik6hrg7h6Qf82z
 7uwF3DxwpDt2SU215GC/BhQTsNjJDk8yjEf29X2Y1GCXakHg0dR0AMJe05Y3z12FJCxr
 xoWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440832; x=1751045632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e45gg72CykCmOosOOuFqCWiWAfKi8lpY1H7Ol6ibhsw=;
 b=vIEfuqZWLLYfLR3tKn6yuPLLAju8Pssk6Ug3+DFvP+KbvEXZzYdsweSLLW696Jlg9j
 Bv5Coys7xY0xAIS6v3d6LjNk7zg7TjF2FRRQz3vpUYOBr5D9qL5TP4ZDxLyDxZCRwjAb
 Gt97qfPgEPdq5f42OHIJVUpXIhWUjgyYNEvkQnjIOGaUDoLsRDDFS6pt0GxUdw4XCVQ7
 kmxMnN+znVt6Unc2SVniJeZaP0aX2bUaRKlqhu7oveB3p5Pdy5l1FBEywT2mlZld5cuc
 X/EyTi2P+pD2f7pWaP3VdpXj5/VNu+CqU0oqlcMJ+hPkTo0iZKrs3kFBmQmLDMNUnAOg
 cGtg==
X-Gm-Message-State: AOJu0Yy/bK6/c9O3aWYxLNVo3uW+A0JIjs1cCDhyZm9ayuBQ5lojSScF
 4q5b7WCEy0gus3RS2CFR45teswwfJ0rVaUOnbbU7Xa4Pg6iNEtY4gxWe1O/DjZKfoFUmWy+enYP
 cvHnPE6jCZg==
X-Gm-Gg: ASbGncsskvoPCLnGe/9Y4D+iiTVKnTUmNYw6teBHOGMEjCTlAzhCRfLBHJg44LM/Odj
 f5BCpfQCYA0ux/9dyXTA6NlLN2p2U9AX7jk+PaA+0Xfnfya3l0/V/vVtt3BtLW0HCRKCOXMUUKh
 akf3EtHOIU+qDFnPaV6iOu/ymWTKh+mDjR0d0pNtzezZpr6v5YQJOqJx3TYB8kA7ZE+xII0NrKf
 u7BLcIXpIyjFDHj7ebbrESqxuNA6BOcw0YE2eHnPvOGuIlhSPuJfGn9dV+hHiaC3dyTN1TNOP/N
 FvkEEmJOuJ6JW68AwVeI6vk4i1MVw+uyKLJDk1Ubzg8Zex1MjVolxbdVXiyG6AQ8WYMfIA1jn5T
 aAhnFLOPC/6RC6dNLBvTKfrL/tV5/wphX+xkuMuqzvtImFZK1FsHp3z/1
X-Google-Smtp-Source: AGHT+IGcYZUXZYf6iok96R2pNKIX2dmGQjV2MNo6RFzyszDFoRzoZ59QYfXpyY37kgrzdrc/4My4Bg==
X-Received: by 2002:a05:600c:8b2a:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-45364790383mr41752405e9.0.1750440831662; 
 Fri, 20 Jun 2025 10:33:51 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646fd6e4sm31090095e9.23.2025.06.20.10.33.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:33:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 42/42] tests/functional: Test Aarch64 virt machine
 with split-accelerator
Date: Fri, 20 Jun 2025 19:27:50 +0200
Message-ID: <20250620172751.94231-43-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/meson.build                |  1 +
 tests/functional/test_aarch64_virt_split.py | 69 +++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 tests/functional/test_aarch64_virt_split.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e9f19d54a27..20d18eb8f5d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -98,6 +98,7 @@ tests_aarch64_system_thorough = [
   'aarch64_tuxrun',
   'aarch64_virt',
   'aarch64_virt_gpu',
+  'aarch64_virt_split',
   'aarch64_xen',
   'aarch64_xlnx_versal',
   'multiprocess',
diff --git a/tests/functional/test_aarch64_virt_split.py b/tests/functional/test_aarch64_virt_split.py
new file mode 100644
index 00000000000..840ffe2f732
--- /dev/null
+++ b/tests/functional/test_aarch64_virt_split.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2024 Linaro Ltd.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+import re
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import exec_command, wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+
+def test_nested_guest(test_instance):
+
+    # TODO:
+    # - kvm-unit-tests
+    # - boot KVM guest
+    pass
+
+def get_accel_transitions(vm):
+    hmp = vm.cmd('human-monitor-command', command_line='info accel')
+    for line in hmp.split('\r\n'):
+        match = re.search(r'Transitions: (\d+)', line)
+        if match is not None:
+            return int(match[1])
+    return 0
+
+
+class Aarch64VirtSplit(QemuSystemTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://fileserver.linaro.org/s/Jao8KCct246QFy2/'
+         'download/Image-6.14.5+initramfs_with_kvm_unit_tests.xz'),
+         '9cc074434b41bce61f0534381dd6912ca6f33524077b02b5f4062a5e696d1b30')
+
+    def test_aarch64_virt_split(self):
+        self.set_machine('virt')
+        self.require_accelerator('split')
+
+        self.vm.set_console()
+
+        kernel = self.uncompress(self.ASSET_KERNEL)
+
+        self.vm.add_args('-accel', 'split')
+        self.vm.add_args('-cpu', 'host')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-M', 'virtualization=on,'
+                               'gic-version=max')
+        self.vm.add_args('-kernel', kernel)
+        self.vm.add_args('-netdev', 'user,id=net0')
+        self.vm.add_args('-append', 'console=ttyAMA0 '
+                                    'kvm-arm.mode=nvhe')
+
+        self.vm.launch()
+        wait_for_console_pattern(self, "CPU: All CPU(s) started at EL2")
+        wait_for_console_pattern(self, "kvm [1]: Hyp nVHE mode initialized")
+        wait_for_console_pattern(self, 'Welcome to Buildroot',
+                                 failure_message='Synchronous Exception at')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+
+        self.assertGreater(get_accel_transitions(self.vm), 13,
+                           "Not enough accel transitions")
+
+        test_nested_guest(self)
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.49.0


