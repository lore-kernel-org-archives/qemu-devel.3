Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A510C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 11:57:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRsQ7-0006P3-OP; Thu, 11 Jul 2024 07:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPZ-00040n-Ro
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sRsPU-0004Ad-BP
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 07:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720698986;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h18LYbjBJTgvDMDvH+3FMrTXwPHvgF54cOWbiPgrN0I=;
 b=ckfJVyoDa2WtiDi5YaeyQoCWy5QDeUbZkDHodejKbKC9P00r3fgQlfp9h4cSK0mFTtk7fM
 g6yYa+y0wmG509Hx94OwVie6ZY1A2laBhR8fWu5U6bI8hk6pRpIJH7UV6gGSBS4ouWH2F5
 LiveEfLDym0RqdiI49uhkYQEmMEeFKU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-M5v_Oe42NuKpmiTR4JIW3Q-1; Thu,
 11 Jul 2024 07:56:23 -0400
X-MC-Unique: M5v_Oe42NuKpmiTR4JIW3Q-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C9BA1954B3F; Thu, 11 Jul 2024 11:56:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.118])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 375F21954219; Thu, 11 Jul 2024 11:56:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 6/8] tests/pytest: Convert some tests that download files
 via fetch_asset()
Date: Thu, 11 Jul 2024 13:55:44 +0200
Message-ID: <20240711115546.40859-7-thuth@redhat.com>
In-Reply-To: <20240711115546.40859-1-thuth@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that we've got a working fetch_asset() function, we can convert
some Avocado tests that use this function for downloading their
required files.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/pytest/meson.build                      | 16 +++++++++++++++
 .../test_machine_arm_n8x0.py}                 | 20 +++++++------------
 .../test_machine_avr6.py}                     |  7 ++-----
 .../test_machine_loongarch.py}                | 11 ++++------
 .../test_machine_mips_loongson3v.py}          | 19 ++++++------------
 5 files changed, 35 insertions(+), 38 deletions(-)
 rename tests/{avocado/machine_arm_n8x0.py => pytest/test_machine_arm_n8x0.py} (71%)
 rename tests/{avocado/machine_avr6.py => pytest/test_machine_avr6.py} (91%)
 rename tests/{avocado/machine_loongarch.py => pytest/test_machine_loongarch.py} (89%)
 rename tests/{avocado/machine_mips_loongson3v.py => pytest/test_machine_mips_loongson3v.py} (59%)

diff --git a/tests/pytest/meson.build b/tests/pytest/meson.build
index 1486628d45..d3607db362 100644
--- a/tests/pytest/meson.build
+++ b/tests/pytest/meson.build
@@ -8,6 +8,22 @@ pytests_generic = [
   'version',
 ]
 
+pytests_arm = [
+  'machine_arm_n8x0',
+]
+
+pytests_avr = [
+  'machine_avr6',
+]
+
+pytests_loongarch64 = [
+  'machine_loongarch',
+]
+
+pytests_mips64el = [
+  'machine_mips_loongson3v',
+]
+
 pytests_x86_64 = [
   'cpu_queries',
   'mem_addr_space',
diff --git a/tests/avocado/machine_arm_n8x0.py b/tests/pytest/test_machine_arm_n8x0.py
similarity index 71%
rename from tests/avocado/machine_arm_n8x0.py
rename to tests/pytest/test_machine_arm_n8x0.py
index 12e9a6803b..082284b975 100644
--- a/tests/avocado/machine_arm_n8x0.py
+++ b/tests/pytest/test_machine_arm_n8x0.py
@@ -10,9 +10,9 @@
 
 import os
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from unittest import skipUnless
+from qemu_pytest import QemuSystemTest
+from qemu_pytest import wait_for_console_pattern
 
 class N8x0Machine(QemuSystemTest):
     """Boots the Linux kernel and checks that the console is operational"""
@@ -32,18 +32,12 @@ def __do_test_n8x0(self):
         self.vm.launch()
         wait_for_console_pattern(self, 'TSC2005 driver initializing')
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_n800(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:n800
-        """
+        self.machine = 'n800'
         self.__do_test_n8x0()
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_n810(self):
-        """
-        :avocado: tags=arch:arm
-        :avocado: tags=machine:n810
-        """
+        self.machine = 'n810'
         self.__do_test_n8x0()
diff --git a/tests/avocado/machine_avr6.py b/tests/pytest/test_machine_avr6.py
similarity index 91%
rename from tests/avocado/machine_avr6.py
rename to tests/pytest/test_machine_avr6.py
index 5485db79c6..479038a221 100644
--- a/tests/avocado/machine_avr6.py
+++ b/tests/pytest/test_machine_avr6.py
@@ -19,16 +19,12 @@
 
 import time
 
-from avocado_qemu import QemuSystemTest
+from qemu_pytest import QemuSystemTest
 
 class AVR6Machine(QemuSystemTest):
     timeout = 5
 
     def test_freertos(self):
-        """
-        :avocado: tags=arch:avr
-        :avocado: tags=machine:arduino-mega-2560-v3
-        """
         """
         https://github.com/seharris/qemu-avr-tests/raw/master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf
         constantly prints out 'ABCDEFGHIJKLMNOPQRSTUVWXABCDEFGHIJKLMNOPQRSTUVWX'
@@ -39,6 +35,7 @@ def test_freertos(self):
         rom_hash = '7eb521f511ca8f2622e0a3c5e8dd686efbb911d4'
         rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
 
+        self.machine = 'arduino-mega-2560-v3'
         self.vm.add_args('-bios', rom_path)
         self.vm.add_args('-nographic')
         self.vm.launch()
diff --git a/tests/avocado/machine_loongarch.py b/tests/pytest/test_machine_loongarch.py
similarity index 89%
rename from tests/avocado/machine_loongarch.py
rename to tests/pytest/test_machine_loongarch.py
index 8de308f2d6..3eb68745ac 100644
--- a/tests/avocado/machine_loongarch.py
+++ b/tests/pytest/test_machine_loongarch.py
@@ -5,9 +5,9 @@
 # Copyright (c) 2023 Loongson Technology Corporation Limited
 #
 
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import exec_command_and_wait_for_pattern
-from avocado_qemu import wait_for_console_pattern
+from qemu_pytest import QemuSystemTest
+from qemu_pytest import exec_command_and_wait_for_pattern
+from qemu_pytest import wait_for_console_pattern
 
 class LoongArchMachine(QemuSystemTest):
     KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
@@ -21,10 +21,7 @@ def wait_for_console_pattern(self, success_message, vm=None):
 
     def test_loongarch64_devices(self):
 
-        """
-        :avocado: tags=arch:loongarch64
-        :avocado: tags=machine:virt
-        """
+        self.machine = 'virt'
 
         kernel_url = ('https://github.com/yangxiaojuan-loongson/qemu-binary/'
                       'releases/download/2024-05-30/vmlinuz.efi')
diff --git a/tests/avocado/machine_mips_loongson3v.py b/tests/pytest/test_machine_mips_loongson3v.py
similarity index 59%
rename from tests/avocado/machine_mips_loongson3v.py
rename to tests/pytest/test_machine_mips_loongson3v.py
index 5194cf18c9..189b22c04e 100644
--- a/tests/avocado/machine_mips_loongson3v.py
+++ b/tests/pytest/test_machine_mips_loongson3v.py
@@ -10,28 +10,21 @@
 import os
 import time
 
-from avocado import skipUnless
-from avocado_qemu import QemuSystemTest
-from avocado_qemu import wait_for_console_pattern
+from unittest import skipUnless
+from qemu_pytest import QemuSystemTest
+from qemu_pytest import wait_for_console_pattern
 
 class MipsLoongson3v(QemuSystemTest):
     timeout = 60
 
-    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
+    @skipUnless(os.getenv('QEMU_TEST_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
     def test_pmon_serial_console(self):
-        """
-        :avocado: tags=arch:mips64el
-        :avocado: tags=endian:little
-        :avocado: tags=machine:loongson3-virt
-        :avocado: tags=cpu:Loongson-3A1000
-        :avocado: tags=device:liointc
-        :avocado: tags=device:goldfish_rtc
-        """
+        self.machine = 'loongson3-virt'
 
         pmon_hash = '7c8b45dd81ccfc55ff28f5aa267a41c3'
         pmon_path = self.fetch_asset('https://github.com/loongson-community/pmon/'
                                     'releases/download/20210112/pmon-3avirt.bin',
-                                     asset_hash=pmon_hash, algorithm='md5')
+                                     asset_hash=pmon_hash)
 
         self.vm.set_console()
         self.vm.add_args('-bios', pmon_path)
-- 
2.45.2


