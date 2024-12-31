Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4FB1E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2024 19:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tShZZ-0004Hf-NL; Tue, 31 Dec 2024 14:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZX-0004HU-Ft
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:31 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tShZV-000835-VV
 for qemu-devel@nongnu.org; Tue, 31 Dec 2024 14:06:31 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-388cae9eb9fso5627594f8f.3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2024 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735671988; x=1736276788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i1yo4w5GnlAYj7AYGNPPXlqGurfVbdqR/bxTMgmzr3s=;
 b=jCIzmScE84tZdOUSl5NUjMpVV2lMfA/nSbuAXYX2EuuV79vHWmsXX73de7Ot1194YH
 qQVUbmF8WlslCmi8KgmerI1ekVJfIRza8aT4dF6AXff85VBZD6KSSBpziU4/bcYjA4aV
 rxTbRdrMI+9QkFftKNnKJYYiUpHwH6T1IiMzSd7lWC9tGj9cQjM7rlPLtSGgoOw303Dm
 lIOFIe/PS7vW44ZFSDHTL34k1ccpewUODDNBpB68Iip3/sdZtoSiN9syg6eHl7iwUQb0
 gjf3asowzNoOdZlkbxVSksbj8fdWp7Ze0/kbokD9/T3ef4fsNWNZjRKJS9ka39KxIIFU
 AuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735671988; x=1736276788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i1yo4w5GnlAYj7AYGNPPXlqGurfVbdqR/bxTMgmzr3s=;
 b=v4+2RcX+LAOUw4UpV3l2FvPygHfOsNW3e2jZHOrFZtG+/SIpfCnPAeMai6KvOvFHZ6
 WFN6Hi8UlkVTX/g6v9iMz2skN2hDkDCuvoklYYTHWiZU3d49ZYUAx0Vp3NTvaA4Q89mT
 AseWSk0HMYuBveH+7o7UJXn0MM3MSWYUrV9wBZFwT0GwBgVQRqOKMY3Bx1sLyIaKKwDb
 +TuMacbum2qPUXlEDuYEocQAkeYZygM7d8rYKil2GF+ppfB5SYsvT26c12WwD20Q4yLQ
 mf2AykXxEbuFYdHu7sHrS9TtQGQfI9LLkvsQ6CvvXzEyCGzxhVhbtemZ27/tNaVjPqlI
 V12A==
X-Gm-Message-State: AOJu0Yy5lhpytnq3eckHXwDVCVQYdqO+el+z/hsQYkiz5y2FKLFIyb2K
 90CqYHC/sXuSR68QJ7YUDMDUcrIFW0z9yiebBENdj81TqxJayJNknGwy1zukeyzvd+nJoaX/63c
 wXPU=
X-Gm-Gg: ASbGncuOoLilX8X+NZ7e6FBneAbQ7CSDCgr5NJIe2qM49EotWKBilKKn+PcoJdoUeMY
 DJO2kzz1N/Ev1BFv0nlG57nEzjOsXkvKRdfFide3Ubb9P+2NRK+ZbrUWuiDK9s348oKPMQXOevX
 Jm7tuKq1zOv9gdKCLUda1Af5wQwie+v1f/4Dh2gdBkH691IA/T4f/1yOMS97uTImYlRbBgLeTRk
 tgrY1txWWzPvQ0FwJnPu9uITQjxy30DC88yEJC4k/P1KieAOlWyfXHu0vxmxQ+RuToo5j6LWkKS
 FxNVGttJoovEk9JZNJ5r3SJUIgnu6WE=
X-Google-Smtp-Source: AGHT+IFaHsjwzxhzJY6h4dbh19kat0/6c3g1yY9qbOvYeNQxV+XTZvZsif8wtY3V/43g9qNL6tUikg==
X-Received: by 2002:a05:6000:4025:b0:388:e2a7:74c8 with SMTP id
 ffacd0b85a97d-38a223ff41dmr35459019f8f.44.1735671987956; 
 Tue, 31 Dec 2024 11:06:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e53sm33389931f8f.27.2024.12.31.11.06.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Dec 2024 11:06:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 1/6] tests: Add functional tests for HPPA machines
Date: Tue, 31 Dec 2024 20:06:15 +0100
Message-ID: <20241231190620.24442-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241231190620.24442-1-philmd@linaro.org>
References: <20241231190620.24442-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
  1/4 qemu:func-quick+func-hppa / func-hppa-empty_cpu_model OK 0.13s 1 subtests passed
  2/4 qemu:func-quick+func-hppa / func-hppa-version         OK 0.14s 1 subtests passed
  3/4 qemu:func-quick+func-hppa / func-hppa-info_usernet    OK 0.22s 1 subtests passed
  4/4 qemu:func-quick+func-hppa / func-hppa-hppa_seabios    OK 0.22s 2 subtests passed

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                           |  1 +
 tests/functional/meson.build          |  4 +++
 tests/functional/test_hppa_seabios.py | 35 +++++++++++++++++++++++++++
 3 files changed, 40 insertions(+)
 create mode 100755 tests/functional/test_hppa_seabios.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 38a290e9c2c..17c720dd2b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1201,6 +1201,7 @@ F: include/hw/pci-host/astro.h
 F: include/hw/pci-host/dino.h
 F: pc-bios/hppa-firmware.img
 F: roms/seabios-hppa/
+F: tests/functional/test_hppa_seabios.py
 
 LoongArch Machines
 ------------------
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
-- 
2.47.1


