Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F384ECD4851
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 00:44:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wO370-0000F8-7a; Fri, 15 May 2026 20:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO36y-0000EO-7h
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:42:36 -0400
Received: from mail-dy1-x1332.google.com ([2607:f8b0:4864:20::1332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1wO36v-0001lo-Nh
 for qemu-devel@nongnu.org; Fri, 15 May 2026 20:42:35 -0400
Received: by mail-dy1-x1332.google.com with SMTP id
 5a478bee46e88-2ee1054627bso1151978eec.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778892152; x=1779496952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6cJm0hJ7ufr2+RXOb+7kuh1u/sSMctsNLG47Vl0SsgM=;
 b=knQ9fI8vVy5dLkgqAp+Ntna1ssug78BRJQVy3dmin9xEb0Ht7LOijDxqHnZILIWwvH
 y3yKPmflieOXsXIsR2UuHMnJhVNavLmUuPwwH6667ss3ojnGja/X3p3ZECg4l2SETL2P
 qSZzyUyOAwOgIFUYNTOEwXTwBEk5GZbN6K6jP4Wd4Qis4TpG3F2UdxngF/udqalY44pp
 deFlMZ2v2Xo+geEDGXfR0EsgdAsAccfe7ZY89sIL9d5hOgWUkTYvSh9y2Yn0/NQEQXdb
 QnI9eqnkWqUCpe5Zf+kDCiFNbCYN2rJqvmprPd0ortputmYeCTQTS4N9R+10XHw8sP0b
 Y0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778892152; x=1779496952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6cJm0hJ7ufr2+RXOb+7kuh1u/sSMctsNLG47Vl0SsgM=;
 b=q/8ShSNupejZdZln90ZpeGPgxe2AlI8BT2xjgIpZTtVwV5H5Gu11/bDJ43Yk3d48MV
 TX8OFAA1puyRJfLfgwB/oFzKHPKh0hHIGEHlrKZ0EZ56UoDh8v6wV88oyvOUFulHOfhe
 SJ57fAOjacJrdDxsiL0POB3lKjYR+l8fb5BB/h8fEQSx3RqbGb9WvyFfU47YOJwRbebU
 efejYs02xltb1DR78qQw0pGdRp2R/G6D+dJMdCYrFhrjdcef/ifHg/GMLy/ZYHvWr3Wa
 VCnD0++2B0kAUqGCabwYcdklNoIVvRvA8SykEEzJUUq1YAqoEB+Zi/Ti+EllSwL+ROE/
 aA+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8y97bTOB2qfVRLmIOpMgHfTlB+kY7zh3ur3FLxZ8yHbPdAkfgiQMd/+QRXQpAqkn4Gnx3PPRFWykUO@nongnu.org
X-Gm-Message-State: AOJu0YxjEO5xgo/is6mvKKJnPZvZjt4sp2Pe7Zuz5QVSVc7LqXsiZLDH
 NoYPUAYBNBd8CjuS+ZjQI3HeiwLfj9htT27UVbTQOVFAA2U2aVsPy12J
X-Gm-Gg: Acq92OHcPOWrCquzUz69hpDxB4Wn24M65SUDzVDprpAPbX8EHsVrKH1FALEvIEKKQJ+
 HBObiwmrBS+6RLYIOBUzv97NDqvyiyUSLHFBRMPJRvSr/4CPe3LhNSMfx9KNzcbaj6gHITdMmY/
 4xoYLMNzLRkfq1oocoDQznW9D+gahy/6HJPYAslgcsMvruEzSbWtrlokBLazPfi1vWtYa8vG3qN
 EDZjUHVjcSRLTdUSfo+VhCk140sWGU573sq4+o7CNbrfnKVqQ6dWbap3I/+/hcl3ypsO4vgomm0
 8q+evxehMasXME7zyZiOVHETxkppXX0JBuk24zfu8QdoRnTPSExELIdrGbPy0T7FTzAo5ilPGwv
 zBocbl97v9v8N7dAGkYlckoG2HBiCphyIHbNUCnmgWh13O7nt/T3xy+XpuEFt4AvhxSHFhgt/Jy
 4KT6isD4SYwFjxniuQxx+prtdtXDAfInDApslemQODiw==
X-Received: by 2002:a05:7301:2c89:b0:2a4:701a:b9ba with SMTP id
 5a478bee46e88-303979af460mr2470303eec.14.1778892152118; 
 Fri, 15 May 2026 17:42:32 -0700 (PDT)
Received: from localhost ([38.104.138.51]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978b3cb2sm10866837eec.30.2026.05.15.17.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 17:42:31 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Andrew Jones <andrew.jones@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>,
 Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 07/10] tests/functional/riscv64: Add tt-atlantis tests
Date: Fri, 15 May 2026 17:42:02 -0700
Message-ID: <20260516004206.169035-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260516004206.169035-1-npiggin@gmail.com>
References: <20260516004206.169035-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1332;
 envelope-from=npiggin@gmail.com; helo=mail-dy1-x1332.google.com
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

Add OpenSBI and Linux boot tests for the tt-atlantis machine. Based on
tests/functional/riscv64/test_sifive_u.py.

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
index 89200d8867..5e4de32533 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1794,6 +1794,7 @@ S: Supported
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


