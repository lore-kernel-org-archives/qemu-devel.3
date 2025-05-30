Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C78C5B549
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 12:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKzBz-0002EH-He; Fri, 30 May 2025 08:50:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBw-0002DV-46
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:32 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uKzBu-0001ut-4G
 for qemu-devel@nongnu.org; Fri, 30 May 2025 08:50:31 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-ad891bb0957so353909366b.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748609427; x=1749214227; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/lzXjjmX1bay6vF6d/3ie7l2smbDsKYexDQ/VeVxRWo=;
 b=uhUOMiSm1wuSXWc/Gw0igRoVXpsHISYWxggy9ml3wNyNWinx6vh1s+boVIazE3FvR0
 cglzdSpLUi4gucJ80UIBxm9RlZTnxjerzStwKSxPOxA1z9Z0mtjMcvMYxtB+wmR7M1nG
 VGlf62dAh/gbnwL7rn0TxZsIpQM5imd9ZZSIVExT2IwjSZaQzm6usPxGQFNJorxtdZb/
 TY1Zksiy5UtESerrSaiWyTq8D98eTzJM+BEgeyn8ekgnt8P1zzWbmr9jbfK6jX19jkyr
 XjcZR7f4pF8KMNT1wMKvWXXpYJ103VTgc7AhSPArjAhoz9QDEsFe8E0BJeWEg31BMVly
 Wl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748609427; x=1749214227;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/lzXjjmX1bay6vF6d/3ie7l2smbDsKYexDQ/VeVxRWo=;
 b=RUZsZ5CjgAkTyw2K0HYK0xKcBYW831ViFrGya5ug3CEXnyyW9FzXvV2UdIhUcFldsO
 2qDLC97mgbeQ+ULIuNNn43bxd9XrMBWuaHhY93WIWeSOYnvKFsA5tZg/QhsAb5HPhQx2
 1wg89WudMB8wMa8jA9TJHIS5c/eevsUvoht3DRutczi+5nzGx0EMs8OttfiDHHLgsxM7
 7vDHjB5f+GuT6ZuYoxLooHqbM1qJMb4B+fcYDm209HYofgLq2mXXt8qYh1+bG3h3uUhl
 +LB3zhXwsfODCjOICnJLQhUM47TfMFan3nfmR6PNis3eE8b5zmve3diKc98y4AN9Jl4Z
 LU9A==
X-Gm-Message-State: AOJu0Yyj/zJxnxWTOj+cagdvM/8LUQwtoph6hzyzaIIAfEHfSOrT3eWi
 ioJay2JgIuU1E6+BR/s7FBY+nouLgpYBCVAFyDMhjJ6jX0GsRO16u7Why8lBSiSbmw9jHT/suNL
 7Jexk
X-Gm-Gg: ASbGncuYWfMptDbfVUZ8cnyrP4NwBuZe2zgES1A72lKqF7jJNRqCy5eQaoK8pRiaq3r
 4N1hfaZOkKn+6R6o6KI30fgAIyPO7GTttlos+V0XMQDlwUItVmEL1ez08YvkSvuSc9Hlk3IA13t
 23GncZ0IAsckuhNxVoXoN3lKtPZmb+UVumwCPs2xkGBIkpkhSAq1ToZKq6clfSA4Sj7Zn0T9Xru
 RQbTvNqdm+mMqj2xo0sY2uUf5oz5lee6VeOTJI9WG9/F5nlJaeg76QLqiqfyetHx4tbBeu4Rr0/
 LbPLaOg0q6w8J07NUfgHcJqXfm/+ylW4jotD2pvEmOn1ZUsdSjzT+a9HVjOJRRCDxZSk
X-Google-Smtp-Source: AGHT+IEKuOV3bfR2KD7pgeElSuGGm3K/XaDYVK23kxxbTYVvARiv/puTfqcxjYfF5GJyLTe2VEA8Cg==
X-Received: by 2002:a05:600c:3b8e:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-450d64e2a97mr36477625e9.3.1748609416736; 
 Fri, 30 May 2025 05:50:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-450d7fb7dafsm17235195e9.25.2025.05.30.05.50.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 05:50:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/15] tests/functional: Add a test for the Stellaris arm
 machines
Date: Fri, 30 May 2025 13:49:51 +0100
Message-ID: <20250530124953.383687-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530124953.383687-1-peter.maydell@linaro.org>
References: <20250530124953.383687-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

The 2023 edition of the QEMU advent calendar featured an image
that we can use to test whether the lm3s6965evb machine is basically
still working.

And for the lm3s811evb there is a small test kernel on github
which can be used to check its UART.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-id: 20250519170242.520805-1-thuth@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                            |  1 +
 tests/functional/meson.build           |  1 +
 tests/functional/test_arm_stellaris.py | 48 ++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100755 tests/functional/test_arm_stellaris.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 973254fae79..16af37986a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1004,6 +1004,7 @@ F: hw/display/ssd03*
 F: include/hw/input/gamepad.h
 F: include/hw/timer/stellaris-gptm.h
 F: docs/system/arm/stellaris.rst
+F: tests/functional/test_arm_stellaris.py
 
 STM32L4x5 SoC Family
 M: Samuel Tardieu <sam@rfc1149.net>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52b4706cfe8..557d59ddf4d 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -137,6 +137,7 @@ tests_arm_system_thorough = [
   'arm_raspi2',
   'arm_replay',
   'arm_smdkc210',
+  'arm_stellaris',
   'arm_sx1',
   'arm_vexpress',
   'arm_virt',
diff --git a/tests/functional/test_arm_stellaris.py b/tests/functional/test_arm_stellaris.py
new file mode 100755
index 00000000000..cbd21cb1a0b
--- /dev/null
+++ b/tests/functional/test_arm_stellaris.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+#
+# Functional test that checks the serial console of the stellaris machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+
+class StellarisMachine(QemuSystemTest):
+
+    ASSET_DAY22 = Asset(
+        'https://www.qemu-advent-calendar.org/2023/download/day22.tar.gz',
+        'ae3a63ef4b7a22c21bfc7fc0d85e402fe95e223308ed23ac854405016431ff51')
+
+    def test_lm3s6965evb(self):
+        self.set_machine('lm3s6965evb')
+        kernel_path = self.archive_extract(self.ASSET_DAY22,
+                                           member='day22/day22.bin')
+        self.vm.set_console()
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'In a one horse open')
+
+    ASSET_NOTMAIN = Asset(
+        'https://github.com/Ahelion/QemuArmM4FDemoSw/raw/master/build/notmain.bin',
+        '6ceda031aa081a420fca2fca9e137fa681d6e3820d820ad1917736cb265e611a')
+
+    def test_lm3s811evb(self):
+        self.set_machine('lm3s811evb')
+        kernel_path = self.ASSET_NOTMAIN.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-cpu', 'cortex-m4')
+        self.vm.add_args('-kernel', kernel_path)
+        self.vm.launch()
+
+        # The test kernel emits an initial '!' and then waits for input.
+        # For each character that we send it responds with a certain
+        # other ASCII character.
+        wait_for_console_pattern(self, '!')
+        exec_command_and_wait_for_pattern(self, '789', 'cdf')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


