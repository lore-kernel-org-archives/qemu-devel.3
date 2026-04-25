Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AAA7FF8860
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Apr 2026 13:20:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGcuZ-0007VT-MT; Sat, 25 Apr 2026 09:19:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcuY-0007Uo-8S
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:19:06 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1wGcuW-0000Iy-F3
 for qemu-devel@nongnu.org; Sat, 25 Apr 2026 09:19:06 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-82f69a286dbso6647625b3a.2
 for <qemu-devel@nongnu.org>; Sat, 25 Apr 2026 06:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777123143; x=1777727943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L96ytGhBLABpw2IZylcy/zQEaxsFjn/Yuu5E+/yR5VY=;
 b=hDL5E6IGS6ZE4gsiaQ9Hc7+BZxaJEEJ6sU2E8tG/SIllpaSp6+H2W25VklzXvd7FTy
 J7fuweRGSMAWraqP2ZxHbtRX6ycFVijzKaQE8AAgDvO048kvtmFmP5VtFHFJ4v8H7jO1
 LyuvH1ADxPfqPbzf83cm7c5+zSAqTnlZng7bXGLKST81wEcLBnqh/8qH4qxT86B/Lkhy
 WkcTyxYirtkzt6TPtJZo90cZA24Im045emc+pi8Z/RRehRuABP4Eeeuh9BdLwIQLBfdR
 gc0eQB5AeM8f2KeeSl7dz3p98jGtOS6WLTDbN+aZG7jfTsEJs2k2hWUrNVXENPiiPvZI
 VsgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777123143; x=1777727943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L96ytGhBLABpw2IZylcy/zQEaxsFjn/Yuu5E+/yR5VY=;
 b=AQGmPZOD9ljhdRe+Is/UluISEdUJk8xciekTCsBPvTTMreeVClq9Vzqa6huxo2LeQd
 zwkB+kaket0zUxEgFgQEm4F91IFMMa+rOFYXpg+kt0hWd+IE+4vv6tIcjjsY8UpwT8Sa
 VWNbEQHMok+rpihHLXa1AAbjx4KPYCNLnpxdP8Jpkxs6CwBPHlpXS+N6Y290DRv/xzIJ
 3yNVRN5wtR2rnSBebqGTd17dIjtP27vjaKxDIkxfJafG4zkS1Zsdd67Meqg5xv8+KhLM
 uyxepu9whi6DPOLs7OPLysIUgV4qxnuyrKYXYlsJERQQ6pO4VyDeRfjNAQEmKKoaIxUC
 achg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/EhP1O8gIJb/1tBTWXLUOQXqoghCJx8iGrMoFORFtvArnuoGG+l96LdpHPQm1UbcTCRBGwnsvJrzs2@nongnu.org
X-Gm-Message-State: AOJu0YwfhvHXGNSVmi35dGy74R9lVhEwOSyNOrOiadqtlsgPzHhYu34h
 3YpJ3Gvvs8SNc6jQMcduOeALx6qMnC8InIwP7XFgeMbjvXf2nEyAzSPa
X-Gm-Gg: AeBDieuXX/TJsESUBoPgx4CRcKZYxDQglwpy0yl0JysgrOn89T7EYnJsMtftH/nkgiM
 UDsjYSzfv5gAhz6r2Z1FJorl0Z5BLtYERkgLTBbrZtpysd3cxr3e8s7abwBOEBLvJ3U7oCI821E
 WsL/MOXE3nrYiJ5npc14+fnBivRJ0AEoGJmjHiVKGod1kHsZMalq7hrhbvR7gJfEsNdWW/YUv1T
 mRIjdYA/R6Ffst1HW2d0gfjXiWaJyCCHauFXJ5Li5n0AOnQigNK9yDmlB90iTo+pymnxeDFHPZD
 uzSU/Gh8e4CrYN7AYLB5ZVvsqdUpYl072aJLL2spYzLyRBR9PqK+0IK/hvryof4vmHoiZTRHIrS
 bC5cKpIIvXX0IlP37rorLTswLk9tKhT2bqaJa3Z8lsZpTvBQUQsF9gfVaoT1w+IqN0slUiGDVct
 +i0wt3ItVFfeKi0MrVuFXmM3omQ0cJ6EvekCbrAN/SrN7lqI1jk2S2f/4rLT/bIXdbhuVaM3Sq1
 GogTTIffwtv/tlfoTBAvck04J1Dfaeo
X-Received: by 2002:a05:6a00:1995:b0:82a:6ef8:cb43 with SMTP id
 d2e1a72fcca58-82f8c84b34emr37955098b3a.19.1777123143028; 
 Sat, 25 Apr 2026 06:19:03 -0700 (PDT)
Received: from donnager-debian.. ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e9f7735sm26898866b3a.21.2026.04.25.06.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 06:19:02 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 11/13] tests/functional/riscv64: Add tt-atlantis tests
Date: Sat, 25 Apr 2026 23:17:17 +1000
Message-ID: <20260425131721.932250-12-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260425131721.932250-1-joel@jms.id.au>
References: <20260425131721.932250-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=joel.stan@gmail.com; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

Add OpenSBI and Linux boot tests for the tt-atlantis machine. Based on
tests/functional/riscv64/test_sifive_u.py.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v4: Remove unnecessary  os.remove(rootfs_path)
v3:
 - Fix path to test files
 - Dedupe command line root argument
 - Remove unused import
---
 MAINTAINERS                                  |  1 +
 tests/functional/riscv64/meson.build         |  1 +
 tests/functional/riscv64/test_opensbi.py     |  4 ++
 tests/functional/riscv64/test_tt_atlantis.py | 59 ++++++++++++++++++++
 4 files changed, 65 insertions(+)
 create mode 100755 tests/functional/riscv64/test_tt_atlantis.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 635a380945fd..9622ffc9edb2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1770,6 +1770,7 @@ F: docs/system/riscv/tt_*.rst
 F: hw/riscv/tt_*.c
 F: hw/riscv/aia.[ch]
 F: include/hw/riscv/tt_*.h
+F: tests/functional/riscv64/test_tt_*.py
 
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index b996c89d7df9..c4456fabd757 100644
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
index d077e40f4278..0f8beb7e7a8c 100755
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
index 000000000000..ce6e7fc63e34
--- /dev/null
+++ b/tests/functional/riscv64/test_tt_atlantis.py
@@ -0,0 +1,59 @@
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
+        self.do_test_riscv64_tt_atlantis(False)
+
+    def test_riscv64_tt_atlantis_disk(self):
+        self.do_test_riscv64_tt_atlantis(True)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.3


