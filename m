Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89A6DE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 09:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTHQF-0004p5-D5; Thu, 02 Jan 2025 04:23:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTHQC-0004ow-E3
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 04:23:16 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTHQA-0006tM-Dz
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 04:23:16 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2f441791e40so12441766a91.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 01:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735809791; x=1736414591; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6zEuQv7QpF6Ie4cNcFdsaWLdFf2BXXaTH2NbRgASESA=;
 b=oU4grogY1aDYyu7OgH9bTOxX8WTIaazWXZdGGiNQXkHlKBfjcQAO4mL/LtAs9y2FT7
 R0jNuC729JKFaeelmBqCMdq0UMOUfm8RpdNEBmvBwEoXm0QAvG38snJca7hAkVYoft9x
 1NG9q4j52h+NUeJvMV2ED61t86jdhEeiONCYlvnZlx1kWBVuPB3fQtx3A65tCPqV5HIC
 BNOjFft+muYciwpvlIWRouV2sbzfBDmRK4pqmDFe3OjsvdKG0OeUIg0MGUI0m728gDSF
 gjpmg81PnZaGCtfwcBJ+Le9QW22dYagdkITHNTwEDBC2lzzAVu4p+LOZEwRtBaz4Sbwx
 NsNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735809791; x=1736414591;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6zEuQv7QpF6Ie4cNcFdsaWLdFf2BXXaTH2NbRgASESA=;
 b=OuMgEhsT2XPyf9cdLQxKwB9Z36GLkXj6I2Qwt0AKAK6YuYDzjMOpLrJq+xfY3mH3r4
 y9NcBfnqdwWRH0uhTDdGpMTqQAUPwfT+5A0HrDK0EphyQjWKnRmnRSHxF5hdoXpeGRNy
 XxDgBfw1q+wLDjXeKMDOiAuK3kRon4y8URL2LI94GYS4Cm6mjnC2XZxk6S9v2ajplGcb
 Lq6eNMEN5hI5fM88Yb/cY6X6gizy0FSJtaNfl28WcAyc7fXJpGvdXDVP6dY+RIwV7PB+
 0RxR7IvA9NO7EFMNQwqlppcw2UmHsGM/To07haRNbq0WfTcCcqCRLiHzrgaybSl40a8U
 mMuQ==
X-Gm-Message-State: AOJu0YzJV6eCzsffMXLWG8mXuJ+qLGNCY8PaMDAi+tNG0iRyQpgLLs/3
 UB0rRSf9SxNeKM0JGP1hRsgdx+iIbiO6qjuWlGe3jmaQZ5E/355i6YeyYDmNwRQBjavdfbKFPgQ
 cggk=
X-Gm-Gg: ASbGncuuADkaoPsa3amoAZ9dRM65mXNz2mw8/NmXBBSCJGeTtWpCCJNSZyeqGqvfmi/
 WNJs4JVG92lFQUMLUu7x4JRu7xu+1dvW/t6H6D8QzC3n2D2Ia7oupd2EJ1CTOkSqKYsYNObD0Uw
 N9DZSG/SOrh6JnD/CNBc3IbLe2hxH9NLqhOTpV+ei4ngCK7UoQ+/b42q0rAz69nbHYJThlmYBJx
 AsR9mEk21K4t1yS/pbESefRBeY+w85TN3YwrlkRUQjlDsmQft6f93WcWdWazxZo13B3kVDCHNgq
 hq09PFMAr6floJ1VF6uFIraepD5TsSU=
X-Google-Smtp-Source: AGHT+IEO3R76AvitlTTOzABcDPdx+m/Uv5jsTIFi33SRV8wbxGAh8UI+4IzsX3KdzemfkkSyGuAxOw==
X-Received: by 2002:a17:90a:c2c7:b0:2ee:ee77:227c with SMTP id
 98e67ed59e1d1-2f452dfaecdmr59747285a91.3.1735809791402; 
 Thu, 02 Jan 2025 01:23:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f447882a3fsm26034602a91.38.2025.01.02.01.23.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 01:23:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5] tests: Add functional tests for HPPA machines
Date: Thu,  2 Jan 2025 10:23:01 +0100
Message-ID: <20250102092301.42122-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102b.google.com
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

Add quick firmware boot tests (less than 1sec) for the
B160L (32-bit) and C3700 (64-bit) HPPA machines:

  $ make check-functional-hppa
  ...
  4/4 qemu:func-quick+func-hppa / func-hppa-hppa_seabios    OK 0.22s 2 subtests passed

Remove the duplicated B160L test in qtest/boot-serial-test.c.

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de>
---
v5: Remove duplicated qtest (th_huth)
---
 MAINTAINERS                           |  1 +
 tests/qtest/boot-serial-test.c        |  2 --
 tests/functional/meson.build          |  4 +++
 tests/functional/test_hppa_seabios.py | 35 +++++++++++++++++++++++++++
 tests/qtest/meson.build               |  2 +-
 5 files changed, 41 insertions(+), 3 deletions(-)
 create mode 100755 tests/functional/test_hppa_seabios.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 2101b512175..770bbf9f233 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1203,6 +1203,7 @@ F: include/hw/pci-host/astro.h
 F: include/hw/pci-host/dino.h
 F: pc-bios/hppa-firmware.img
 F: roms/seabios-hppa/
+F: tests/functional/test_hppa_seabios.py
 
 LoongArch Machines
 ------------------
diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 3b92fa5d506..7ea24855072 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -184,8 +184,6 @@ static const testdef_t tests[] = {
     { "microblazeel", "petalogix-ml605", "", "TT",
       sizeof(kernel_plml605), kernel_plml605 },
     { "arm", "raspi2b", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
-    /* For hppa, force bios to output to serial by disabling graphics. */
-    { "hppa", "hppa", "-vga none", "SeaBIOS wants SYSTEM HALT" },
     { "aarch64", "virt", "-cpu max", "TT", sizeof(kernel_aarch64),
       kernel_aarch64 },
     { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 24f7f8f2f1c..71810a3aa82 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -104,6 +104,10 @@ tests_avr_system_thorough = [
   'avr_mega2560',
 ]
 
+tests_hppa_system_quick = [
+  'hppa_seabios',
+]
+
 tests_i386_system_thorough = [
   'i386_tuxrun',
 ]
diff --git a/tests/functional/test_hppa_seabios.py b/tests/functional/test_hppa_seabios.py
new file mode 100755
index 00000000000..a44d1a3eebe
--- /dev/null
+++ b/tests/functional/test_hppa_seabios.py
@@ -0,0 +1,35 @@
+#!/usr/bin/env python3
+#
+# SeaBIOS boot test for HPPA machines
+#
+# Copyright (c) 2024 Linaro, Ltd
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest
+from qemu_test import wait_for_console_pattern
+
+class HppaSeabios(QemuSystemTest):
+
+    timeout = 5
+    MACH_BITS = {'B160L': 32, 'C3700': 64}
+
+    def boot_seabios(self):
+        mach = self.machine
+        bits = self.MACH_BITS[mach]
+        self.vm.set_console()
+        self.vm.launch()
+        self.machine
+        wait_for_console_pattern(self, f'SeaBIOS PA-RISC {bits}-bit Firmware')
+        wait_for_console_pattern(self, f'Emulated machine:     HP {mach} ({bits}-bit')
+
+    def test_hppa_32(self):
+        self.set_machine('B160L')
+        self.boot_seabios()
+
+    def test_hppa_64(self):
+        self.set_machine('C3700')
+        self.boot_seabios()
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index c5a70021c50..ab296a97a78 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -140,7 +140,7 @@ qtests_alpha = ['boot-serial-test'] + \
 
 qtests_avr = [ 'boot-serial-test' ]
 
-qtests_hppa = ['boot-serial-test'] + \
+qtests_hppa = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : [])
 
-- 
2.47.1


