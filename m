Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6792D58D5A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 15:22:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFatw-00043B-A1; Mon, 25 Nov 2024 10:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatt-00041d-Oz
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:21 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tFatq-0001nT-W1
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 10:21:21 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3825c05cc90so2936901f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2024 07:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732548077; x=1733152877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+pOvKcIYLYjxSCH4Q48xgGtD5Zj0tOeOWXKJv+fQtdI=;
 b=F9lEJZh/OpF2jRsjN0n0mCsA8+qnriL4x0RZ8AmfN2B3aypt1KsIGepksWss6iJtn9
 kc16f7/X9sjlThXfZCpiGdzJTjG84/eXniiEul3pSwe1kGFqCxXazrAukah6RvLB3YVg
 pxdVUr8B1/WWorqROvWtivQgC9P6DJkNXfgOAyocbuDvCr1414/vVscEqW02uZ6nfxq4
 4UfZGL8ISJDdc11UoX/L9vZqu3cVFRtAQl1qTyJgWdS8SuqjyyghUgp8XAcSCojssBMl
 cuAUY0XJLokwZROqJzhDKsOgn1lT3V0LA16SqUbIiQAx1QzbwPcxLfxZbkbaluaoSrbE
 kIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732548077; x=1733152877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+pOvKcIYLYjxSCH4Q48xgGtD5Zj0tOeOWXKJv+fQtdI=;
 b=nZGHDBehMKsr+TjDHb2zAOb7R7RXxnEHr3ePJBQZMcnBS/ua9cnsXjB1TeiKeb70bC
 bLZ33JSuQR0nGtnfQbgLJuiYJbeRuyrEJmFYAyPwFAVNOuF+8unGTvzA47DFYeVQZj1F
 6hpa3SDDPK12Tz41pzcrrMoBg/ex4R0ru30gDydFx0O94B9DyJYpCm8V30XcgobuLoOu
 gcsFxRPMNa6LBraZIepQo+SXSX9mtaOoXBfnPTAk7FeVlmSRf4Z9XZKGOS+zRMgVTSgC
 Iq+d6g3Yfm4AYs53h6Am5AR3OKBv8D6jw72mMx/D0I5SDAPWHuA1UGSyrKH+w3GZh4Wg
 Nz5Q==
X-Gm-Message-State: AOJu0YyFtKcNAtcoCzijUsLRth2q1pAmdyAFwR2ruF1oy7W2MoobL+ep
 f07E4I7QDKP/VCX9SpIwMKerx9awnfsrXREs3L5rw2zdo5xd8SZxCzDCct48iXs=
X-Gm-Gg: ASbGncumVOM5+hu3cWBHBQCFFXq3LnCsJOg4OaOXuQsY+4sW79f52HfkTo46Hr6cZOK
 JUPYvydhdvCv4u+9OOUw7Knt1vyz6OA04pZKHNNSLdbOcn7UsCW60F7ebX34ir0Bcx6xIUC5ypA
 wxqrBqYmzxTb2fgeueF5uXSYGgDpwJwCWwXs1K8JjnROrwD9nWwEEqaXj1GIWE6v+AC0ASBImov
 lyfv6NcnbirxDIf+9hEsgjkZGULhZM+8IMkMcEXalC4Wc2h
X-Google-Smtp-Source: AGHT+IH3vfZTAk1rY21ftHnQBkgC8g2Bv/YWU9EtMMaX9lpdRgPnTKLlgZ0SVLEK4LvETa16l131xw==
X-Received: by 2002:a05:6000:1543:b0:37c:d12c:17e5 with SMTP id
 ffacd0b85a97d-38260b6bb95mr10721419f8f.23.1732548077505; 
 Mon, 25 Nov 2024 07:21:17 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fbedfb2sm10633531f8f.105.2024.11.25.07.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 07:21:15 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2DD7363937;
 Mon, 25 Nov 2024 15:21:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 qemu-arm@nongnu.org (open list:ASPEED BMCs)
Subject: [PULL 26/28] tests/functional: Convert Aspeed aarch64 SDK tests
Date: Mon, 25 Nov 2024 15:21:03 +0000
Message-Id: <20241125152105.2100395-27-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125152105.2100395-1-alex.bennee@linaro.org>
References: <20241125152105.2100395-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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

From: Cédric Le Goater <clg@redhat.com>

Drop the SSH connection which was introduced in the avocado tests to
workaround read issues when interacting with console.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20241122090322.1934697-2-clg@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspeed.py
index 241ef180af..2240c82abf 100644
--- a/tests/avocado/machine_aspeed.py
+++ b/tests/avocado/machine_aspeed.py
@@ -59,17 +59,6 @@ def do_test_arm_aspeed_sdk_start(self, image):
             self, 'boot', '## Loading kernel from FIT Image')
         self.wait_for_console_pattern('Starting kernel ...')
 
-    def do_test_aarch64_aspeed_sdk_start(self, image):
-        self.vm.set_console()
-        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
-                         '-net', 'nic', '-net', 'user,hostfwd=:127.0.0.1:0-:22')
-
-        self.vm.launch()
-
-        self.wait_for_console_pattern('U-Boot 2023.10')
-        self.wait_for_console_pattern('## Loading kernel from FIT Image')
-        self.wait_for_console_pattern('Starting kernel ...')
-
     @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on GitLab')
     def test_arm_ast2500_evb_sdk(self):
         """
@@ -133,70 +122,3 @@ def test_arm_ast2600_evb_sdk(self):
         year = time.strftime("%Y")
         self.ssh_command_output_contains('/sbin/hwclock -f /dev/rtc1', year);
 
-    def test_aarch64_ast2700_evb_sdk_v09_02(self):
-        """
-        :avocado: tags=arch:aarch64
-        :avocado: tags=machine:ast2700-evb
-        """
-
-        image_url = ('https://github.com/AspeedTech-BMC/openbmc/releases/'
-                     'download/v09.02/ast2700-default-obmc.tar.gz')
-        image_hash = 'ac969c2602f4e6bdb69562ff466b89ae3fe1d86e1f6797bb7969d787f82116a7'
-        image_path = self.fetch_asset(image_url, asset_hash=image_hash,
-                                      algorithm='sha256')
-        archive.extract(image_path, self.workdir)
-
-        num_cpu = 4
-        image_dir = self.workdir + '/ast2700-default/'
-        uboot_size = os.path.getsize(image_dir + 'u-boot-nodtb.bin')
-        uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
-
-        load_images_list = [
-            {
-                'addr': '0x400000000',
-                'file': image_dir + 'u-boot-nodtb.bin'
-            },
-            {
-                'addr': str(uboot_dtb_load_addr),
-                'file': image_dir + 'u-boot.dtb'
-            },
-            {
-                'addr': '0x430000000',
-                'file': image_dir + 'bl31.bin'
-            },
-            {
-                'addr': '0x430080000',
-                'file': image_dir + 'optee/tee-raw.bin'
-            }
-        ]
-
-        for load_image in load_images_list:
-            addr = load_image['addr']
-            file = load_image['file']
-            self.vm.add_args('-device',
-                             f'loader,force-raw=on,addr={addr},file={file}')
-
-        for i in range(num_cpu):
-            self.vm.add_args('-device',
-                             f'loader,addr=0x430000000,cpu-num={i}')
-
-        self.vm.add_args('-smp', str(num_cpu))
-        self.vm.add_args('-device',
-                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
-        self.do_test_aarch64_aspeed_sdk_start(image_dir + 'image-bmc')
-        self.wait_for_console_pattern('nodistro.0 ast2700-default ttyS12')
-
-        self.ssh_connect('root', '0penBmc', False)
-        self.ssh_command('dmesg -c > /dev/null')
-
-        self.ssh_command_output_contains(
-            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device '
-            '&& dmesg -c',
-            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
-
-        self.ssh_command_output_contains(
-            'cat /sys/class/hwmon/hwmon20/temp1_input', '0')
-        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
-                    property='temperature', value=18000)
-        self.ssh_command_output_contains(
-            'cat /sys/class/hwmon/hwmon20/temp1_input', '18000')
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 923f9e7078..d6d2c0196c 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -11,6 +11,7 @@ endif
 
 # Timeouts for individual tests that can be slow e.g. with debugging enabled
 test_timeouts = {
+  'aarch64_aspeed' : 600,
   'aarch64_raspi4' : 480,
   'aarch64_sbsaref_alpine' : 720,
   'aarch64_sbsaref_freebsd' : 720,
@@ -48,6 +49,7 @@ tests_generic_bsduser = [
 ]
 
 tests_aarch64_system_thorough = [
+  'aarch64_aspeed',
   'aarch64_raspi3',
   'aarch64_raspi4',
   'aarch64_sbsaref',
diff --git a/tests/functional/test_aarch64_aspeed.py b/tests/functional/test_aarch64_aspeed.py
new file mode 100644
index 0000000000..59916efd71
--- /dev/null
+++ b/tests/functional/test_aarch64_aspeed.py
@@ -0,0 +1,98 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED SoCs with firmware
+#
+# Copyright (C) 2022 ASPEED Technology Inc
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import sys
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import exec_command_and_wait_for_pattern
+from qemu_test.utils import archive_extract
+
+class AST2x00MachineSDK(QemuSystemTest):
+
+    def do_test_aarch64_aspeed_sdk_start(self, image):
+        self.require_netdev('user')
+        self.vm.set_console()
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
+                         '-net', 'nic', '-net', 'user', '-snapshot')
+
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'U-Boot 2023.10')
+        wait_for_console_pattern(self, '## Loading kernel from FIT Image')
+        wait_for_console_pattern(self, 'Starting kernel ...')
+
+    ASSET_SDK_V902_AST2700 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v09.02/ast2700-default-obmc.tar.gz',
+            'ac969c2602f4e6bdb69562ff466b89ae3fe1d86e1f6797bb7969d787f82116a7')
+
+    def test_aarch64_ast2700_evb_sdk_v09_02(self):
+        self.set_machine('ast2700-evb')
+
+        image_path = self.ASSET_SDK_V902_AST2700.fetch()
+        archive_extract(image_path, self.workdir)
+
+        num_cpu = 4
+        image_dir = self.workdir + '/ast2700-default/'
+        uboot_size = os.path.getsize(image_dir + 'u-boot-nodtb.bin')
+        uboot_dtb_load_addr = hex(0x400000000 + uboot_size)
+
+        load_images_list = [
+            {
+                'addr': '0x400000000',
+                'file': image_dir + 'u-boot-nodtb.bin'
+            },
+            {
+                'addr': str(uboot_dtb_load_addr),
+                'file': image_dir + 'u-boot.dtb'
+            },
+            {
+                'addr': '0x430000000',
+                'file': image_dir + 'bl31.bin'
+            },
+            {
+                'addr': '0x430080000',
+                'file': image_dir + 'optee/tee-raw.bin'
+            }
+        ]
+
+        for load_image in load_images_list:
+            addr = load_image['addr']
+            file = load_image['file']
+            self.vm.add_args('-device',
+                             f'loader,force-raw=on,addr={addr},file={file}')
+
+        for i in range(num_cpu):
+            self.vm.add_args('-device',
+                             f'loader,addr=0x430000000,cpu-num={i}')
+
+        self.vm.add_args('-smp', str(num_cpu))
+        self.vm.add_args('-device',
+                         'tmp105,bus=aspeed.i2c.bus.1,address=0x4d,id=tmp-test')
+        self.do_test_aarch64_aspeed_sdk_start(image_dir + 'image-bmc')
+
+        wait_for_console_pattern(self, 'ast2700-default login:')
+
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self,
+            '0penBmc', 'root@ast2700-default:~#')
+
+        exec_command_and_wait_for_pattern(self,
+            'echo lm75 0x4d > /sys/class/i2c-dev/i2c-1/device/new_device ',
+            'i2c i2c-1: new_device: Instantiated device lm75 at 0x4d');
+        exec_command_and_wait_for_pattern(self,
+            'cat /sys/class/hwmon/hwmon20/temp1_input', '0')
+        self.vm.cmd('qom-set', path='/machine/peripheral/tmp-test',
+                    property='temperature', value=18000)
+        exec_command_and_wait_for_pattern(self,
+            'cat /sys/class/hwmon/hwmon20/temp1_input', '18000')
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.39.5


