Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60ACCD3427
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 04:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKqXF-0000p2-0l; Thu, 07 May 2026 00:40:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqXD-0000oD-8n
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:40:27 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wKqXB-00049W-6u
 for qemu-devel@nongnu.org; Thu, 07 May 2026 00:40:27 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso2537095ad.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 21:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778128824; x=1778733624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUD7XHPgCxrezwQ6+Da0nSaGVgnJAs27dGSg8/ZO85g=;
 b=Kg/m3wavUezD6zkpZzOHEKTyPzVKHcNzD5alRnqheyl66Zr9IDSV+wwUGl8irCFu8/
 BfBAZ4XOCRn/USGs6g8z5G4LbW322BnQQ4XGa+PWGuItVevMFizjRCU6qIyFoIev7gzI
 hJqyH9haOQErYAot5pMm6TPZa48P389c81t8iT1c2N3HmKCdAQAJVGJ3+RcGmum8fQs0
 zIivbKCPdZBbAzlPuXi+zNnmHOMFNK2MTcg0fwvE/md8BJZ8LbsPBG8tmJHcQ7iUoQxz
 q8CNIhYlQKSgnSl1uBetEcM1Qh0F0MYowiuw25SuFoH9enK7Vhh5e35RK7dyHwgNxwab
 L2/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778128824; x=1778733624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QUD7XHPgCxrezwQ6+Da0nSaGVgnJAs27dGSg8/ZO85g=;
 b=RDMN3ZGSMvLm4kzovC9eS3QKLt6bV9uZXf2W7QiXqPGcHRgVbWpWk9Mh2iAneJu56c
 RLMYFVz07rLHqJBBaW1+j/gMMOZ1cr5Pi0DDrJtHnu9qR/gLvNoEtIg8KpEnpDN5K0VA
 NhMag0F5Z5SeYbOsN1107+gxZ7mFiZGOlgZTVsGxSVROU99M4IzevlBRqShdvhtw5h+i
 tyAmSbqsB+zbJFgrDRPc5QexQqHtKM+R0XnTcu6g71ihfFNCXJw8MKyEj82DR9pydTqc
 kDzaVUP1fhvA1BjqMk7hNd8aHzwC2rCnSwNSWYxr3z9BkDVlhFuJGLbAWnUxHX6KE0eq
 IQzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/BSL2HWAjLPXWZA54L5lS6o243alDBpsxzMAn2jezzXOMCboRLzAKgtTbB8fAyux1wIiS5T2HDl/iz@nongnu.org
X-Gm-Message-State: AOJu0Ywn8l57zPtT0MqDQQ7DmnetWedQpTIXxUP6Z1M8QU+hhy9OVxC+
 qAX9rgdqfJ87oHjWOuEj7e0tLF+Z6Onl5gXNcVSboKdM3ZAmWbs3vM9f
X-Gm-Gg: AeBDiesbGUFWuij84mr5jiS5Hml0DETnF5Hal8T9VJrr4guQSRDU8l6+URv9NM3AN0a
 mgTaKEUkyROyGquPLIDuMkuV5V9PdFl/jJ0eV6mc2cHLs5624V7yiNe7Hviy8HQ8tlUip5mxBRi
 PxwDKdZxP8oxPpVLxijml0A7sY2Xi05E9ADcdIRztLhqifmcZQXhT1Ww2iVDDQ2c9KXrclWHB92
 oQXXdv5prT24BgxEbRJpBHVDJIyOgUOBJsQFZ6EYzCvCYj103j0YgDGrSD1sP/gwgj9ceXZzVXv
 WvIoRup1mctp/Qw6QgzOF4nIWu7Mxf8RlX/djlJSZ02M60UwEhq6XdqZggqebn8iJ0HNunt0kBT
 a0MlXaeGEuNuyYgcA9mznx6bcxMSjbvsZX9PoQadMQrhy9u4TctZpwL/BgP8nbvm9storadYa2N
 pbR3NIjmGgms4khQuIOcnVsIsB/OrFI1veCoT0h/m59BRWlacFQ1V5CEaSgKS805eYedjvT3a+C
 wxkbY8MUZYA3jr4sz0=
X-Received: by 2002:a17:903:2986:b0:2b4:6597:44d9 with SMTP id
 d9443c01a7336-2babc96104emr11118075ad.8.1778128823834; 
 Wed, 06 May 2026 21:40:23 -0700 (PDT)
Received: from localhost (124.158.97.178.qld.leaptel.network. [124.158.97.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2babadee7c8sm9086415ad.57.2026.05.06.21.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 21:40:23 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Chao Liu <chao.liu.zevorn@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Subject: [PATCH v5 9/9] tests/functional/riscv64: Add tt-atlantis tests
Date: Thu,  7 May 2026 14:38:37 +1000
Message-ID: <20260507043838.45652-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507043838.45652-1-npiggin@gmail.com>
References: <20260507043838.45652-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add OpenSBI and Linux boot tests for the tt-atlantis machine.
Based on tests/functional/riscv64/test_sifive_u.py.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 MAINTAINERS                                  |  1 +
 tests/functional/riscv64/meson.build         |  1 +
 tests/functional/riscv64/test_opensbi.py     |  4 ++
 tests/functional/riscv64/test_tt_atlantis.py | 57 ++++++++++++++++++++
 4 files changed, 63 insertions(+)
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ab5f3e45b..e106cadb81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1776,6 +1776,7 @@ S: Supported
 F: docs/system/riscv/tt_*.rst
 F: hw/riscv/tt_*.c
 F: include/hw/riscv/tt_*.h
+F: tests/functional/riscv64/test_tt_*.py
 
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index b996c89d7d..c4456fabd7 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -13,5 +13,6 @@ tests_riscv64_system_quick = [
 tests_riscv64_system_thorough = [
   'boston',
   'sifive_u',
+  'tt_atlantis',
   'tuxrun',
 ]
diff --git a/tests/functional/riscv64/test_opensbi.py b/tests/functional/riscv64/test_opensbi.py
index d077e40f42..0f8beb7e7a 100755
--- a/tests/functional/riscv64/test_opensbi.py
+++ b/tests/functional/riscv64/test_opensbi.py
@@ -28,6 +28,10 @@ def test_riscv_sifive_u(self):
         self.set_machine('sifive_u')
         self.boot_opensbi()
 
+    def test_riscv_tt_atlantis(self):
+        self.set_machine('tt-atlantis')
+        self.boot_opensbi()
+
     def test_riscv_virt(self):
         self.set_machine('virt')
         self.boot_opensbi()
diff --git a/tests/functional/riscv64/test_tt_atlantis.py b/tests/functional/riscv64/test_tt_atlantis.py
new file mode 100755
index 0000000000..48abd5cd27
--- /dev/null
+++ b/tests/functional/riscv64/test_tt_atlantis.py
@@ -0,0 +1,57 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Tenstorrent Atlantis machine
+# and checks the console
+#
+# Copyright (c) Linaro Ltd.
+# Copyright 2026 Tenstorrent
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset, LinuxKernelTest
+
+
+class TTAtlantis(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0')
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
+         'rootfs.ext2.gz'),
+        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
+
+    def do_test_riscv64_tt_atlantis(self, connect_disk):
+        self.set_machine('tt-atlantis')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
+
+        self.vm.set_console()
+        kernel_command_line = self.KERNEL_COMMON_COMMAND_LINE + 'earlycon=sbi '
+
+        if connect_disk:
+            kernel_command_line += 'root=/dev/vda panic=-1 noreboot rootwait '
+            self.vm.add_args('-device',
+                             'virtio-blk,drive=drive0,serial=0x1234,bus=pcie.0')
+            self.vm.add_args('-drive',
+                             f'file={rootfs_path},if=none,id=drive0,format=raw')
+            pattern = 'Boot successful.'
+        else:
+            kernel_command_line += 'panic=0 noreboot '
+            pattern = 'Cannot open root device'
+
+        self.vm.add_args('-kernel', kernel_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+
+        self.vm.launch()
+        self.wait_for_console_pattern(pattern)
+
+    def test_riscv64_tt_atlantis(self):
+        # tt-atlantis machine has no PCI host yet, so no disk
+        self.do_test_riscv64_tt_atlantis(False)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.53.0


