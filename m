Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF330CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 04:36:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBn3j-0003hi-90; Thu, 23 Oct 2025 00:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3a-0003fX-H0
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:10 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vBn3Y-0001Tx-Dg
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 00:36:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so5314925ad.2
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 21:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761194167; x=1761798967; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oyZKOh+rzZ0zczXaWYSET1LW4b+ObLJI6u80dyIk1s0=;
 b=GyFAaMjkk0BvA1Thnq4A11U2dxngSICxiCTF/5yBNbnXb7rXC0t8prjy8gqpZuksyG
 YrUR7r9F6o2Ci18T7fvBvwbU+gYbkjC7ni1h4HDqUVZ7xZ8STxvtKocvjhvwInRm9xOI
 dgPP4JKZDBtp7cvh/2QW9Fi9yDa59ykcjteRD8xwbkpb8usIsUen5POMMnch9caXeio7
 5Fh1xq5QFGTih6q5Hfy8pKDLW1CtcH+os+M7LQrU+hIDzdci2xbflFZxEDBl7z1qhX54
 5oD2kj1Ok/CJBZDgymnmGffq3oLphe1iOVhboBC4DUNUn8d3sI9Fv3P458p16TO2WQ/T
 dX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761194167; x=1761798967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oyZKOh+rzZ0zczXaWYSET1LW4b+ObLJI6u80dyIk1s0=;
 b=rcnF9kVoBva6/Q3GpqS5z+xUj2Zutaj903yoTt9/rFnj103WDMUMs9xiyZQqdqx9zi
 L508EaHObCf2kvnN9hFlQHWOOF/eomkCAqqUQ4LArMQWmQiqQiCzxpAeTrh6McsISns+
 NDokAl1NndCGPqYsBCeMIgLXu5I0ha2dy6D+Lk6fbZ/nm/3Bivih6Y2k+TS1A351ntUV
 AO54SQM9E0q+hGji+3dWbymHXC19oImajx/y8/0pqP1W3fPKwp1+0iN/LrH9a4E+s33z
 N/bl9zeB+GIlfJHAatdW9KW0cHjcWi6O8pFZ/h+uN87niPjR/67XL4NaNKskv8n07wpS
 DvUg==
X-Gm-Message-State: AOJu0YxH4yIrraRQ9thnrP0VSob274AhvLBKpDQE6QHtajVM+XUGJw1d
 KERCFF9HjkMq1ZMexs+8eiS1iVzSg1LU4AZpcPTx7O6sfKP2a+KFOYql2s3kQw==
X-Gm-Gg: ASbGncuNGKLobg5AOVKFrcWISou1QbB9eCRfbTrBHKzgmvWRDur+C3ybtTtGeEQQrVj
 E8J4lqax5vh3XO+GaFcEB9tyfxWoH5lo8h2fGyEN8nYPmauiYATAggVoOqWQv/zfrIfm3uDHhs8
 k9/0OUAXz0YDn2eHSW13C1bw2c33fFn7QxFsKLf6kjalu1hfRgMSDftKMseCEQSo7z7VdG6vg6N
 CfyTV/z8oMU10vMLWHW6k9lyA/zYoeB9FJC4BEXWj4IpEbQGTPKl407COEP9PZa0lx7Y8BENsZj
 cXm7x7HJLrYN0aePfhdCMU/KOipm4ydC6sL3F9rY24kA34ruS7nm928AYznjbUYTnAqwisY9t4E
 4hUkf1INBfAyhmCDzFVFnZPbxc6ZpDXHSN/6YKad7Cqi+pS151VE5hSEtpdO54vaWPfzV1VlVXE
 UVut5KLAhOCHUnwX7PXM5RhU9RupawMm+i3vY1aaEQL4t+WT3+nl+h+vyuEwqPHeVnrMnk2v8RM
 v3mBteQ0zRU3MURPRY=
X-Google-Smtp-Source: AGHT+IHbwOVXVtPY4CGp2rCBWih9AWKc56D2dxsvjtRLj9p7hrroVLxNBiJ7nYQls7UJsWkJmZkBfg==
X-Received: by 2002:a17:902:eccb:b0:278:9051:8e9c with SMTP id
 d9443c01a7336-290cb07a023mr326553735ad.42.1761194166589; 
 Wed, 22 Oct 2025 21:36:06 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2946dfc113csm8643015ad.68.2025.10.22.21.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 21:36:05 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>,
 Djordje Todorovic <djordje.todorovic@htecgroup.com>,
 Alistair Francis <alistair.francis@wdc.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 31/37] test/functional: Add test for boston-aia board
Date: Thu, 23 Oct 2025 14:35:14 +1000
Message-ID: <20251023043520.1777130-10-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023043520.1777130-1-alistair.francis@wdc.com>
References: <20251023043520.1777130-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x634.google.com
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

From: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>

Add functional test for Boston AIA board. The P8700 RISC-V based
CPU by MIPS supports it at the moment.

Signed-off-by: Chao-ying Fu <cfu@mips.com>
Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20251018154522.745788-14-djordje.todorovic@htecgroup.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/functional/riscv64/meson.build    |   2 +
 tests/functional/riscv64/test_boston.py | 123 ++++++++++++++++++++++++
 2 files changed, 125 insertions(+)
 create mode 100755 tests/functional/riscv64/test_boston.py

diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
index c1704d9275..f30d583a29 100644
--- a/tests/functional/riscv64/meson.build
+++ b/tests/functional/riscv64/meson.build
@@ -1,12 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 test_riscv64_timeouts = {
+  'boston' : 120,
   'tuxrun' : 120,
 }
 
 tests_riscv64_system_quick = [
   'migration',
   'opensbi',
+  'boston',
 ]
 
 tests_riscv64_system_thorough = [
diff --git a/tests/functional/riscv64/test_boston.py b/tests/functional/riscv64/test_boston.py
new file mode 100755
index 0000000000..385de6a61d
--- /dev/null
+++ b/tests/functional/riscv64/test_boston.py
@@ -0,0 +1,123 @@
+#!/usr/bin/env python3
+#
+# Boston board test for RISC-V P8700 processor by MIPS
+#
+# Copyright (c) 2025 MIPS
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+
+
+class RiscvBostonTest(QemuSystemTest):
+    """
+    Test the boston-aia board with P8700 processor
+    """
+
+    ASSET_FW_PAYLOAD = Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/fw_payload.bin',
+        'd6f4ae14d0c178c1d0bb38ddf64557536ca8602a588b220729a8aa17caa383aa')
+
+    ASSET_ROOTFS = Asset(
+        'https://github.com/MIPS/linux-test-downloads/raw/main/p8700/rootfs.ext2',
+        'f937e21b588f0d1d17d10a063053979686897bbbbc5e9617a5582f7c1f48e565')
+
+    def _boot_linux_test(self, smp_count):
+        """Common setup and boot test for Linux on Boston board
+
+        Args:
+            smp_count: Number of CPUs to use for SMP
+        """
+        self.set_machine('boston-aia')
+        fw_payload_path = self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        self.vm.add_args('-cpu', 'mips-p8700')
+        self.vm.add_args('-m', '2G')
+        self.vm.add_args('-smp', str(smp_count))
+        self.vm.add_args('-kernel', fw_payload_path)
+        self.vm.add_args('-drive', f'file={rootfs_path},format=raw,snapshot=on')
+
+        self.vm.set_console()
+        self.vm.launch()
+
+        # Wait for OpenSBI
+        wait_for_console_pattern(self, 'OpenSBI')
+
+        # Wait for Linux kernel boot
+        wait_for_console_pattern(self, 'Linux version')
+        wait_for_console_pattern(self, 'Machine model: MIPS P8700')
+
+        # Test e1000e network card functionality
+        wait_for_console_pattern(self, 'e1000e')
+        wait_for_console_pattern(self, 'Network Connection')
+
+        # Wait for boot to complete - system reaches login prompt
+        wait_for_console_pattern(self, 'Run /sbin/init as init process')
+
+    def test_boston_boot_linux_min_cpus(self):
+        """
+        Test Linux kernel boot with minimum CPU count (2)
+        """
+        self._boot_linux_test(smp_count=2)
+
+    def test_boston_boot_linux_7_cpus(self):
+        """
+        Test Linux kernel boot with 7 CPUs
+
+        7 CPUs is a special configuration that tests odd CPU count
+        handling and ensures proper core distribution across clusters.
+        """
+        self._boot_linux_test(smp_count=7)
+
+    def test_boston_boot_linux_35_cpus(self):
+        """
+        Test Linux kernel boot with 35 CPUs
+
+        35 CPUs is a special configuration that tests a non-power-of-2
+        CPU count above 32, validating proper handling of larger
+        asymmetric SMP configurations.
+        """
+        self._boot_linux_test(smp_count=35)
+
+    def test_boston_boot_linux_max_cpus(self):
+        """
+        Test Linux kernel boot with maximum supported CPU count (64)
+        """
+        self._boot_linux_test(smp_count=64)
+
+    def test_boston_invalid_cpu_count(self):
+        """
+        Test that 65 CPUs is rejected as invalid (negative test case)
+        """
+        from subprocess import run, PIPE
+
+        fw_payload_path = self.ASSET_FW_PAYLOAD.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+
+        cmd = [
+            self.qemu_bin,
+            '-M', 'boston-aia',
+            '-cpu', 'mips-p8700',
+            '-m', '2G',
+            '-smp', '65',
+            '-kernel', fw_payload_path,
+            '-drive', f'file={rootfs_path},format=raw,snapshot=on',
+            '-nographic'
+        ]
+
+        # Run QEMU and expect it to fail immediately.
+        result = run(cmd, capture_output=True, text=True, timeout=5)
+
+        # Check that QEMU exited with error code 1
+        self.assertEqual(result.returncode, 1,
+                         "QEMU should exit with code 1 for invalid SMP count")
+
+        # Check error message
+        self.assertIn('Invalid SMP CPUs 65', result.stderr,
+                      "Error message should indicate invalid SMP CPU count")
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.51.0


