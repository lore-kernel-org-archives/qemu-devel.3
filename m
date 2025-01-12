Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E15A0E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:24:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6K5-0004DI-0p; Sun, 12 Jan 2025 17:20:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Jq-0003f5-9a
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:30 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Jo-0006q7-BI
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:30 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385d7f19f20so1901610f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720426; x=1737325226; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gox+mQXvKnTFBCqTtoOMoUjxZD4B4okZw2yrEckqptY=;
 b=B/xOerJBd90kjwW8Xm+ppNoJyzPubdJfP8IuF8kV4WhBkSkG19hC5DTrmzGKeNmw6m
 FTAToq07+qZobPF4eQIJgAwpqAWibUC157b8ItPJk2p+XeIktwLH5XqdN/z+7u8lgyzJ
 W99znRIC9JaoKtEXsg3bMi/KZwRTwWaci/z3rq7lI84EQAGJ31S2fXm4QQzcKwovdLaI
 FLcpZLbgVOC17m4N6X27nVtBK0w234QS1uTlgoGniF/Gx0ESLqEKLFpbBybg69SsEZaR
 /suYDgsVkOUEILfhw5Iv2yxB2hbr3ZvDU2dpmkY6CX69ZHdqRXCOXYYTuTfngSXpdi1F
 4Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720426; x=1737325226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gox+mQXvKnTFBCqTtoOMoUjxZD4B4okZw2yrEckqptY=;
 b=wCBPDiYFN1uPIJHoRU+o3U1omsPJBbvd9RWxLvSvip6Qalhx67KxzWgrtlNBrvVdup
 zvUDhvBz2eEUEiOGOn/CAhQ+++j+YMqrjZFI8N4c59CD+c4hV/R+DDWiO+KYby7d4n13
 DsJ+DtLwv5sZklMHlWJmXBoxgsifi7aMpEw5QoRBTrDWppTiI22ErxbHCFjw21QEBz45
 mu15oKTLpMocZcc8IjoFkhxfddDtbk25HqLRhTz7vc8B99Koit8bQxB2mjnONSK0S6nZ
 0oTsSLVpvRs4TCRkTtV+5Jvf6+RvAdbgEAYgwXiBuuUA1uVczp8Qv7fUrgMl2D2lqGum
 Tizg==
X-Gm-Message-State: AOJu0Yxpbb6QcIjxO7seEMi0Mh+rFXWW6eaPtPP/Kw4StALvKiDends3
 jeQnkuJN3PbJa4J9ys7IXBu0Ht9PGWEZ3V8xkhzG+bhuf3horeZLMhdjxLexlZBY0J631kbml0t
 3nVw=
X-Gm-Gg: ASbGncvUbaf3LvkN38N9pFI5H5EaTMiAfP1zT9Qw96Hma6vhxZ2D4SQfpjnjORDo7Ca
 LnMGJLlZFIur0NZD4WnXiB3M+ngN6z1MuPm9Y8Oo7IjzfkYZrntHQu/emM69gCM1rDeJMSojdpr
 WJc/x1YMiiNr3roKy1sur6nUXR2ry8F2SUJaFAeREBLbHvm/Gh2f3hGeBSGkIyhfcBKAbebSdOr
 KkALOtjdk1Ff2gFSKLBOsa3OxOWh/kQgmQPQJg/SYQ8qabF/PXkwqFiKhrA9bypdrs67ZkOwXlD
 Q0z/k9iyOt3zVZoKek43onZcpyUxVc0=
X-Google-Smtp-Source: AGHT+IGmSoHtJlGlEnCNzELZj/eySiOWNqL8nrpKAhBWZHNj3DXPEo28dQhzq9Vp5d8T2BiaQmRRFQ==
X-Received: by 2002:a5d:5f52:0:b0:38a:50f7:240c with SMTP id
 ffacd0b85a97d-38a8735760fmr15270966f8f.47.1736720426655; 
 Sun, 12 Jan 2025 14:20:26 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c596sm10637730f8f.51.2025.01.12.14.20.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 36/49] tests: Add functional tests for HPPA machines
Date: Sun, 12 Jan 2025 23:17:12 +0100
Message-ID: <20250112221726.30206-37-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250102100340.43014-3-philmd@linaro.org>
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
index 7759e8c9702..7ea24855072 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -184,8 +184,6 @@ static const testdef_t tests[] = {
     { "microblazeel", "petalogix-ml605", "", "TT",
       sizeof(kernel_plml605), kernel_plml605 },
     { "arm", "raspi2b", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
-    /* For hppa, force bios to output to serial by disabling graphics. */
-    { "hppa", "B160L", "-vga none", "SeaBIOS wants SYSTEM HALT" },
     { "aarch64", "virt", "-cpu max", "TT", sizeof(kernel_aarch64),
       kernel_aarch64 },
     { "arm", "microbit", "", "T", sizeof(kernel_nrf51), kernel_nrf51 },
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index a5087fcb34f..999d5b930f3 100644
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


