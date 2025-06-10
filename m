Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BEFC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyYM-0007Wf-FZ; Tue, 10 Jun 2025 08:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXn-0006qA-Au
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:36 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXk-0002e5-TR
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:34 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so4142225f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560250; x=1750165050; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MnthyjpLQDqIlW5Rsj/+WcVAlzOijs/T5Gp1lZVZxOc=;
 b=q0wkKOuMsO76pEcIzDuIdzeHZcQkY4Jf+JNGYpTtIjnLamEXlORzH1cIcnivb5ezLh
 UagSe46Xo58CFLwqRPYao1kp3Jh2c7zDGJJxRxR5O6hCOGiCPBnkVaKWl/2Bg1cL0w/o
 sevh2qkRgZT7W4nFQfhf8xhkKlGsuwqihGY2n4lNsMiHO6K1NqnDlhu1yXXpZXTkZ4BD
 qoqlgSUzofNO/bhlopLQ/3Yznq26YVs6rPOMwf6juzqAy1L7NqnEfWbMTCjKsnkIceru
 JHgD66kMOHOae8fPbOB4gXA6/MfeP3juDtJXy6y7tgTDRCOHdYwNYYw4miSj7Uo4kobg
 OH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560250; x=1750165050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MnthyjpLQDqIlW5Rsj/+WcVAlzOijs/T5Gp1lZVZxOc=;
 b=uMlusNvyxxjSewgeSw0WrnHY40amWmq1B61bcrJPLneAEgoGu3m8gqgQesziNimICS
 niF5Z4TspUpGKTHXXppJLtn3Q+bTIaM6xhRWyHVp/pTgzkYXfcUUEyYSqrAnDB6KSu+H
 NNZZQTBOEt8usWROc0Jvbf/WyhccM7QmhVlyMhIOCqGmYPrdiTk44wAEZB0RAu/jJzcT
 uQ7yOoc4jyAVxPsVPB80o6MRrCMr7q4y+9VuGD7I4kcOaSjV3TszT3i6jm+y2yxVYbvl
 iptBat4Qc0oKak74Et0zB05VS5hmosVENvTMtUM/5wQIy9W1I9oOGi1O23Y+UZyjFOzs
 OTWA==
X-Gm-Message-State: AOJu0YxSU4bIX51FGqXYiZOzd4V9WCgs8AY75ntP0CmekJ2r2aPxYK/3
 oqzkytjhLgL2/osoKJU1XflKtH+3+3Z1+O65+mlTQSPpKi2rOadKcc4cMuUaHHO+s/CWgdnbJmV
 P7Cg62Zo=
X-Gm-Gg: ASbGncvU9mmgzdki4h61xvrEaMmxbWyD+hnmD8wT4Bw/YeQpliiBOUF7ibdw5Ozs9WT
 ATYlMXN+EQS7sEREfovEV+Oi5NZUvzGkJDwZPY9lbqv9WS3nQcCjFHSwnOH0wIgiSdck4XG4F4B
 uYI+iSb+3hkYY4aCbUPNW4fXqHumRXAJ/Xstv8nez7TvKfg3fnr38aUI0L/2SgDpsfxvjNqk+yy
 VSd+Lkgbzg7Esqnmu/WuDzlbrl+N3tsAZx4zBSkVr0u8o4ha2iHU/cd0zqzHF8UryOQ0l89h39g
 +GKF1V2AnE8L0DjYYnT9g381l8ZMJ+u6SWGpx1+Acik8Zu6TVB9urcAFy5j67GSBBVNUkxbGZHX
 hzrY/1e7NfF8dZ5PH3VNUB6Xyh+Q3eo+0SLtXUa7gWA==
X-Google-Smtp-Source: AGHT+IE10hUOUvJ7qnc9yd8M9DLJSU2Z29kL7ZUoBYb3/j+b9dO9Igt2VkRCqUjjNQYIuDUi6Fmpcw==
X-Received: by 2002:a05:6000:178f:b0:3a4:f73e:abb1 with SMTP id
 ffacd0b85a97d-3a5513e3554mr3592555f8f.4.1749560250456; 
 Tue, 10 Jun 2025 05:57:30 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323b59d0sm12374996f8f.38.2025.06.10.05.57.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/24] tests/functional: Add a test for the Arduino UNO machine
Date: Tue, 10 Jun 2025 14:56:21 +0200
Message-ID: <20250610125633.24411-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Thomas Huth <thuth@redhat.com>

Check whether we can run a kernel that prints something to the
serial console.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Message-ID: <20250603184007.24521-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                      |  3 ++-
 tests/functional/meson.build     |  1 +
 tests/functional/test_avr_uno.py | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100755 tests/functional/test_avr_uno.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 76399ad1e0e..a6f210dba5a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -219,7 +219,7 @@ S: Maintained
 F: docs/system/target-avr.rst
 F: gdb-xml/avr-cpu.xml
 F: target/avr/
-F: tests/functional/test_avr_mega2560.py
+F: tests/functional/test_avr_*.py
 
 Hexagon TCG CPUs
 M: Brian Cain <brian.cain@oss.qualcomm.com>
@@ -1236,6 +1236,7 @@ Arduino
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Maintained
 F: hw/avr/arduino.c
+F: tests/functional/test_avr_uno.py
 
 HP-PARISC Machines
 ------------------
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 557d59ddf4d..e406451cd3c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -150,6 +150,7 @@ tests_arm_linuxuser_thorough = [
 
 tests_avr_system_thorough = [
   'avr_mega2560',
+  'avr_uno',
 ]
 
 tests_hppa_system_quick = [
diff --git a/tests/functional/test_avr_uno.py b/tests/functional/test_avr_uno.py
new file mode 100755
index 00000000000..adb3b73da4f
--- /dev/null
+++ b/tests/functional/test_avr_uno.py
@@ -0,0 +1,32 @@
+#!/usr/bin/env python3
+#
+# QEMU AVR Arduino UNO functional test
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
+
+
+class UnoMachine(QemuSystemTest):
+
+    ASSET_UNO = Asset(
+        ('https://github.com/RahulRNandan/LED_Blink_AVR/raw/'
+         'c6d602cbb974a193/build/main.elf'),
+        '3009a4e2cf5c5b65142f538abdf66d4dc6bc6beab7e552fff9ae314583761b72')
+
+    def test_uno(self):
+        """
+        The binary constantly prints out 'LED Blink'
+        """
+        self.set_machine('arduino-uno')
+        rom_path = self.ASSET_UNO.fetch()
+
+        self.vm.add_args('-bios', rom_path)
+        self.vm.set_console()
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'LED Blink')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.49.0


