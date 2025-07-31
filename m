Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C7BC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhb3N-0001Z3-8l; Thu, 31 Jul 2025 17:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapy-0002kr-7U
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:29:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhapu-000821-IR
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:29:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4589180b266so7748255e9.3
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753997352; x=1754602152; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2FIRUMDpl11/+6iqYUzz4llQoL/Y4stMiRg59uk/HY=;
 b=nI5aWwBbgS4/3jj4QclFp4DPnG9nlqDlDl4PptZzoX5cPAAnxU1y1JP9wIRQhAVy96
 0di5d87KF7tQ9z9CssVTygRZi6Wi1yaFtRPHKzMAKGUJIUOf7tC3lzfGkz3Ij6fMC7v+
 lpOAnDYrULItqi1NHfjVg2ll+MPE5hS8WenZkauvblvqd10j+e444zAZqFqYz/jNuELc
 UUtFgDg+p+XWdUJS0CQAEN5sxayI1dvz89+pHAm/C7CCBH/Wlbh910YTATaZ/bPY3Jff
 UobuwfoP5soClhSusZHt2zskv5b/QTH/h0bFboV2LhyRW7klZgW+R+kieZwxjUAb5z8e
 RWoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753997352; x=1754602152;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2FIRUMDpl11/+6iqYUzz4llQoL/Y4stMiRg59uk/HY=;
 b=JlRZmSpCn3yVDO3+iVuvOoG3YZEMfvFfWPtCnoMCFXFWS+4QK1qk+qyLGfAnC94icf
 HPqU5kVnXgRxGuQjk/o8Ra86vyhcVLlil+PYtkPQh90XyKcIYKE70mYRLm1Nspbe+/Nx
 Dr3Cv7bo1NDJ+M4u8CmyM9kchQ2DpR3/aKmdJt6rj/tEvxhiwCAZ8mtZ+MiNTD002ceH
 cB7bltLbJD1oHZ1n/R0NpWQ7twbtSRbQL4M1D6UaGh2W05YAyFmcItu2FsQQbxtqCgcF
 ZVxVXehGVkmRF5BL8Xw3NS48iqLK1xIhMp72hB9u7PzRorZ638xqqqvxOMObs2g9zq1U
 XgdA==
X-Gm-Message-State: AOJu0YylVnfFUp0OD5vCoepZfl7vV/kjxo7sDBCXL1UJnwyPAyuGMiCZ
 FK8g/oQPtlikkZeEXO2GuxaQykmcmRNEmlfMlsDK7KwBrgu4PAmmA1+XD+cA0T0dkIofyWEKpWH
 MjqCw
X-Gm-Gg: ASbGncvyMe7drYXyPXNDxnQ0ROJWgOcF1xPg80LeiISJAmEUckzeRXNflqEM2XCSEz2
 ueTPpw+0LLGhKhFmRc3deba/BePexuZ5gFrgY9Exn3wVhOx1RfJcrhlJpsnzENANm44T3Qg6cnf
 1UMqOyRwruzTJlh7DXNX72/ruMtDRDWcz8M/x60CNMdFyPhznUqqDpKrpCmdmoF/vT8urxxnPw3
 SXaHreAUnq8vg+jfw123av9XCObbujUZvsoZbLIBzedB9WDiFhOwBCnakZtLAvufyjKELC3FKEu
 ucuOWDQt+XR30IFyVEU7Bh8ZO30D9OwI6uFoGvz5QAei/JKhBS7Zayl3PEjuRsVrNjQ2uYRwU+f
 PjuBGi1YDkUaB3J9VbSZhFgYtnNkfwJHiNiH/Pe6ErYJWLyhDNItu7BkgonSSFgF8OAz2vIvHs9
 5okxyfnQo=
X-Google-Smtp-Source: AGHT+IGSxKGjIkWomQpPZ+Q2oiTHoCOtsF8wM+sVIizuyr27pSTSNaZMdLadjcbbAE+YlD76mrFYaQ==
X-Received: by 2002:a05:600c:1c8d:b0:456:496:2100 with SMTP id
 5b1f17b1804b1-45892ce7477mr79287005e9.31.1753997352454; 
 Thu, 31 Jul 2025 14:29:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589edfc930sm40383785e9.8.2025.07.31.14.29.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 31 Jul 2025 14:29:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>, qemu-riscv@nongnu.org,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Weiwei Li <liwei1518@gmail.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Subject: [PATCH-for-10.1 11/11] tests/functional: Test SD cards in SPI mode
 (using sifive_u machine)
Date: Thu, 31 Jul 2025 23:28:06 +0200
Message-ID: <20250731212807.2706-12-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250731212807.2706-1-philmd@linaro.org>
References: <20250731212807.2706-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
index 069d77f2f80..25ee0eb3b0d 100644
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


