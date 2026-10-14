Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68ABCC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 03:41:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGpqu-00065B-LG; Tue, 13 Oct 2026 23:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqp-0005z8-W4
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:25 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1xGpqo-0001dC-7U
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 23:40:23 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-cc4b1f7e8f4so2193005a12.1
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 20:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791949221; x=1792554021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Gy63YQt3lMUN41DPH04wnhXjE9xcTgPZmTMce2BK9Qw=;
 b=XLzxFRjCfW1C1qyow6f9lek25IiKB7UkjRLKFx2xEs821dz2MW9cqBujUflnKdO8eQ
 PPpNtHZltx9gV5RWzYVJJrQSmlU+6k43msOU3MQkvQsawnRcKMOOu9t/HG25HlHxVsIv
 8ACbFz8dyznJarwFpAF+3Nfd3ntWDyn8M0VFS3dqepEGS/25n0YMK5+r3mr5lOemillg
 cwG38PU3QgbTjOssAgcm28ysZIofWuZKTsQJh713Q99VQtQ0TmMuKbC7rAgAsFaAYjyb
 l/8L42CPGUBol5pG3XFZsEpbJUjyUpTmftz2LiPR3fJGSDfcWP3irPFC1DLUDB2ZEfY5
 0dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791949221; x=1792554021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Gy63YQt3lMUN41DPH04wnhXjE9xcTgPZmTMce2BK9Qw=;
 b=Wnq0qfDmnc4Lu0DsKcum7KGS2DEc9EVythuF9uOPEkSSIkOCNTje0j1PM4qQNmM9gW
 wfMJ2yoiUpYawuediN30j2XpB1BybhAtFgJ2jRyN5rKbML8+tM8T52+r36FxFNq+qCKg
 7dIZsHXnnkzLZbbckbkIptyJLzQGoLH/u9cuuEZrhhe5LYP7chFAQo90SoCMpcX8dVAI
 NFVao0andyQBGQZbmcb+kDaOt+WjGZjMcccehf/87t4FAsTDNbph3meR10f+Zl2DT2UU
 ZLLFY70dPe9Pb1QU57e4J7UyuORUAMKiPkfFaMG+t2FXazp9Wm2jdTUvH7GA02kXRsZC
 qYuA==
X-Gm-Message-State: AFq9FYKwuc7eXQRonjGwvx8MNsnMbfEky/EuHfhY936PBfMbY6Gw70MU
 nuvJw5AFlrr+10WvhrScaezD9wmuD8FBiRrOUe5wulXvWkTGUkx2+xaq4GHozw==
X-Gm-Gg: AYBFou27U4fbnjfmjZik6baFmWTuYLsW/01KoLYdou2qS934iupRPM4JFmeATKniGX1
 BpOx/nJantPywf86yElXKBzoXuTrLsaB+6zqbU6P1/rqnqIZdu3DRZvn2CESngO3WPPa0kaKKgM
 Im93MmdCiHF/P3siPiJTK+L6mO2IlkiV1E+bGPFcmW3qfCb3iUcKOp3UxOmiCTFhLCAWShCbett
 9QLq4doEft1pDvwV4HiZzGBDJ6QeEFQMBFd+vTo3gYOZ7DVkmrIM/r9q8YFEv1Rq8fPhu/EzJOw
 mgc55dfW5FXfgHRBAKQvgDWzBgeSP9DOH74VQmv0TkjhdcP770tjvjrIvVx8b9BTljBkRlBP925
 Zgu39YGie7kncJiuwPImVhu+DJJNKl7dcKVgXXe/USMqIFGdtdCZiXNa53eTlpak6HV+PgQAgyg
 B0hIaT86OAnOFk/9LhmPVnyTeVqvSo8g1LBWbV670pyVhsVLxsSvr3LG1ToTCdm4SB9JBDoWP3V
 iR0R9l7cOCIq9jb
X-Received: by 2002:a17:90b:2d8e:b0:3ab:c674:d83c with SMTP id
 98e67ed59e1d1-3abc674eb8amr6852828a91.27.1791949220936; 
 Tue, 13 Oct 2026 20:40:20 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac61170b7bsm2321457a91.16.2026.10.13.20.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 20:40:20 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 19/52] tests/functional/riscv64: Add boot test for Milk-V Duo
 board
Date: Wed, 14 Oct 2026 13:38:34 +1000
Message-ID: <20261014033907.3332383-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014033907.3332383-1-alistair.francis@wdc.com>
References: <20261014033907.3332383-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Add a functional boot test for the Milk-V Duo board to validate the
end-to-end boot flow.

$ ./build/run ./tests/functional/riscv64/test_milkv_duo.py
TAP version 13
ok 1 test_milkv_duo.MilkvDuoMachine.test_riscv64_milkv_duo
1..1

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Message-ID: <20260927201326.650943-7-visitorckw@gmail.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 MAINTAINERS                                |  1 +
 tests/functional/riscv64/meson.build       |  1 +
 tests/functional/riscv64/test_milkv_duo.py | 53 ++++++++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100755 tests/functional/riscv64/test_milkv_duo.py

diff --git a/MAINTAINERS b/MAINTAINERS
index b38e694b1c..4092228bea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1883,6 +1883,7 @@ F: hw/riscv/cv1800b.c
 F: hw/riscv/milkv_duo.c
 F: include/hw/misc/cv1800b_clk.h
 F: include/hw/riscv/cv1800b.h
+F: tests/functional/riscv64/test_milkv_duo.py
 F: tests/qtest/milkv-duo-test.c
 
 RX Machines
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index d1a3e6c2bf..8a4f1d00f9 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -18,4 +18,5 @@ tests_riscv64_system_thorough = [
   'sifive_u',
   'tt_atlantis',
   'tuxrun',
+  'milkv_duo',
 ]
diff --git a/tests/functional/riscv64/test_milkv_duo.py b/tests/functional/riscv64/test_milkv_duo.py
new file mode 100755
index 0000000000..6a7e2a5d19
--- /dev/null
+++ b/tests/functional/riscv64/test_milkv_duo.py
@@ -0,0 +1,53 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Milk-V Duo machine
+#
+# Copyright (c) 2026 Kuan-Wei Chiu <visitorckw@gmail.com>
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test import skipIfMissingCommands, wait_for_console_pattern
+
+class MilkvDuoMachine(LinuxKernelTest):
+
+    timeout = 120
+
+    ASSET_KERNEL = Asset(
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/Image',
+        '174f8bb87f08961e54fa3fcd954a8e31f4645f6d6af4dd43983d5e9841490fb0'
+    )
+    ASSET_DTBS = Asset(
+        'https://storage.tuxboot.com/kernels/6.11.9/riscv64/dtbs.tar.xz',
+        '97e5e65a7e6c68303e53486af120c0846ee8df572e9c15f0c4dccb831d0cef4b'
+    )
+    ASSET_ROOTFS = Asset(
+        'https://storage.tuxboot.com/buildroot/20241119/riscv64/rootfs.ext4.zst',
+        'aa4736a9872651dfc0d95e709465eedf1134fd19d42b8cb305bfd776f9801004'
+    )
+
+    @skipIfMissingCommands('zstd')
+    def test_riscv64_milkv_duo(self):
+        self.set_machine('milkv-duo')
+
+        kernel_path = self.ASSET_KERNEL.fetch()
+        dtb_path = self.archive_extract(
+            self.ASSET_DTBS, member='dtbs/sophgo/cv1800b-milkv-duo.dtb')
+        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
+
+        self.vm.set_console()
+        self.vm.add_args('-bios', 'default',
+                         '-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-drive', f'file={rootfs_path},format=raw,id=sd-card,snapshot=on',
+                         '-device', 'sd-card,drive=sd-card',
+                         '-append', 'console=ttyS0,115200 root=/dev/mmcblk0 rootwait earlycon')
+
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'Machine model: Milk-V Duo')
+        wait_for_console_pattern(self, 'Welcome to TuxTest')
+        wait_for_console_pattern(self, 'tuxtest login:')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.55.0


