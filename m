Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31FFC87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 15:10:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiwoz-0002ep-Uh; Mon, 04 Aug 2025 11:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivLN-0001HO-4b
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:35:15 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uivLG-0000K9-UJ
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 09:35:11 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3b78310b296so2666711f8f.2
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 06:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754314504; x=1754919304; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AmAgMWToY4+su5olx/EK5AlpIDPmCEY+1rTl/kaiArI=;
 b=cZzTcnC3sMbU2sziZI6uRFBCvesf4CoCwSnKDOo7l/fJqDyu2rGClx+4YH6ex4pZs1
 sXMenYEAwfQrL2LvS2ozEc7l7pmRpOdkVJvBVOjR4M/kaiwN0eISGEo7cqJ2oUS5SXpx
 QU8GCqqX/pteNrEtswAnOFO/EsTR0SNxUmuu2QyhXOTx8GIscXmijn/QvJ7wbFMIE+62
 HdjYeMOA3G0E/wy5z9PR1C6iKbqdpjxVTQQ5GpTfq+2RIRL5ZGhz8i8a+3yDFAnrriIi
 wJL6Ee4tZ/4lfn/na36PejloQ8XUfYeU9Kcdtt1HgDRceMiLhYTRNbC5dxt2T9cCmDJe
 sLMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754314504; x=1754919304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AmAgMWToY4+su5olx/EK5AlpIDPmCEY+1rTl/kaiArI=;
 b=vU6Jmehcu+g/HKA0In5HbaAJMZiTivkVGPO1O6q9s7pf/dUrF+Xq5s6PMLnfswkz5a
 s822yHViJefKWHDlCiKT87L1qwvLa3Oc5vxB3xq9RoK6kd93rGIp/mQ1CRaUjbadH044
 9ODh2+3vtort2xBCBGqQ8bHGtHs6R9qCeTbiaGXzDxj0fOZCPFyWtyg7eg8e/crywxRt
 vT6iTUabRBPi+RvXMiPgTRlWq9su2o5vZWMZwnQrbIOmMUrGQLxMaoDiLKpZ4P+IBUyf
 IML8vkfaWj4pUCwngCh8X7WCsz4iaKu6aCRLZR8O3WuSvYx42O6qYgGy0pIKsRZwkPvE
 a8Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvmmDlXwElr7IH0Xy8fq1vFL0DEV3royb+DTXFKFIHeN/AK4/ZvGvTvlf7ya63jiQ1K15OTsMgugnb@nongnu.org
X-Gm-Message-State: AOJu0YxK7bIykNMvCep5QmwDuFBAV5vsEPqIW44egVXqVWakwUfEK8o9
 RQqGNLwWAoshTo0yN2KzPECyzhIUS1wanqV/l1KczRtbkxhnMQWcbibA5VY5QIJPc1Q=
X-Gm-Gg: ASbGncuYsmp0Ynde69y9QtVYNnd9rzNs6X8AJu9wW2Km76UmtCvvLMs4nzKSeur1GFp
 WtAkj830pO+yimjBPbyjHm8QI8UneHdvWB0+wPL4fjQ3pKspTnwUDWipnKSC7ttzgfFzHH/TTDH
 pk9cYILt26kJqKPK0kPWcFvBx05W3VvmgRykDNhFSPgGQOuubgmtk8iENe6bxzCZsNrTSin/l7l
 xalDR5OY6da+On1SUzKoStaimlZepeMU8Vx0svlP6ZLH2cVgFCdO2XNJwZU+naCBzDyUWQOspkp
 EhvbnvQxOyJk9bSnujDcT9+/BAkfs9BtDHPlSwNgrzBds4eC/XqBA2E0r4DPWYz71g14E0DMfq3
 k5t7kHivFrkiSr6fqITs4v07udP1/v60eENa5//xQXFcUwjQ1kIgSlHsp7BORzPERINd0qfYp
X-Google-Smtp-Source: AGHT+IGxNG5Ow1nr5+sFQch0aLzlqqprX0lPY7GoGdyWTrgDl0zWy2hE3QfFq5v9SQuq2n7nGQJ+dw==
X-Received: by 2002:a5d:5f87:0:b0:3b8:d360:3383 with SMTP id
 ffacd0b85a97d-3b8d94c9ff5mr7236289f8f.46.1754314503580; 
 Mon, 04 Aug 2025 06:35:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589edfcdd0sm167480675e9.10.2025.08.04.06.35.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 04 Aug 2025 06:35:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org,
 Guenter Roeck <linux@roeck-us.net>, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH-for-10.1 v2 11/11] tests/functional: Test SD cards in SPI mode
 (using sifive_u machine)
Date: Mon,  4 Aug 2025 15:34:05 +0200
Message-ID: <20250804133406.17456-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804133406.17456-1-philmd@linaro.org>
References: <20250804133406.17456-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a test which uses the sifive_u machine to boot a Linux
kernel from a SD card connected via a SPI interface.

Inspired from the command provided in:
- https://lore.kernel.org/qemu-devel/94b2c5bf-53d0-4c74-8264-f3021916f38c@roeck-us.net/
- https://lore.kernel.org/qemu-devel/840016d0-0d49-4ef4-8372-b62b3bcd0ac6@codethink.co.uk/

Inspired-by: Guenter Roeck <linux@roeck-us.net>
Inspired-by: Ben Dooks <ben.dooks@codethink.co.uk>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                               |  1 +
 tests/functional/meson.build              |  1 +
 tests/functional/test_riscv64_sifive_u.py | 51 +++++++++++++++++++++++
 3 files changed, 53 insertions(+)
 create mode 100755 tests/functional/test_riscv64_sifive_u.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 28cea342718..a07086ed762 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1695,6 +1695,7 @@ S: Supported
 F: docs/system/riscv/sifive_u.rst
 F: hw/*/*sifive*.c
 F: include/hw/*/*sifive*.h
+F: tests/functional/test_riscv64_sifive_u.py
 
 AMD Microblaze-V Generic Board
 M: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ecf965adc6c..311c6f18065 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -274,6 +274,7 @@ tests_riscv64_system_quick = [
 ]
 
 tests_riscv64_system_thorough = [
+  'riscv64_sifive_u',
   'riscv64_tuxrun',
 ]
 
diff --git a/tests/functional/test_riscv64_sifive_u.py b/tests/functional/test_riscv64_sifive_u.py
new file mode 100755
index 00000000000..dc4cb8a4a96
--- /dev/null
+++ b/tests/functional/test_riscv64_sifive_u.py
@@ -0,0 +1,51 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a Sifive U machine
+# and checks the console
+#
+# Copyright (c) Linaro Ltd.
+#
+# Author:
+#  Philippe Mathieu-Daudé
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import Asset, LinuxKernelTest
+from qemu_test import skipIfMissingCommands
+
+
+class SifiveU(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        'https://storage.tuxboot.com/buildroot/20241119/riscv64/Image',
+        '2bd8132a3bf21570290042324fff48c987f42f2a00c08de979f43f0662ebadba')
+    ASSET_ROOTFS = Asset(
+        ('https://github.com/groeck/linux-build-test/raw/'
+         '9819da19e6eef291686fdd7b029ea00e764dc62f/rootfs/riscv64/'
+         'rootfs.ext2.gz'),
+        'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
+
+    def test_riscv64_sifive_u_mmc_spi(self):
+        self.set_machine('sifive_u')
+        kernel_path = self.ASSET_KERNEL.fetch()
+        rootfs_path = self.uncompress(self.ASSET_ROOTFS)
+
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'root=/dev/mmcblk0 rootwait '
+                               'earlycon=sbi console=ttySIF0 '
+                               'panic=-1 noreboot')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-drive', f'file={rootfs_path},if=sd,format=raw',
+                         '-append', kernel_command_line,
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern('Boot successful.')
+
+        os.remove(rootfs_path)
+
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.49.0


