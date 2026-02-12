Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69FDEEA85A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:43:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQP-0008Lq-52; Thu, 12 Feb 2026 16:40:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQM-0008JR-JF
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQK-0006BU-Hc
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QqfC/Y4H9AQxjD2fA3eZ8vbjWhVvXuBuXTwWYX84JS8=;
 b=T00uM7yqP6/wQQPUdOeX/ZPpy9DdVOy4/jNLmkFYb/KHorS8LC35GsBerldDwVZz8ty82n
 r0bSbwVodxRt+Ws/2snLL+v+D28gXePI5vdavNOW8+mH4iVJT7Q5iQR63kRiQ9IlMgqB0b
 xXw4OPx/bgj+97bNxPN1Bs5Ujddxbrw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-sbp7CGQTMEmeyIT-doSvaA-1; Thu,
 12 Feb 2026 16:40:28 -0500
X-MC-Unique: sbp7CGQTMEmeyIT-doSvaA-1
X-Mimecast-MFC-AGG-ID: sbp7CGQTMEmeyIT-doSvaA_1770932427
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 781EB180047F; Thu, 12 Feb 2026 21:40:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E01061800668; Thu, 12 Feb 2026 21:40:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/16] tests/functional/aarch64/test_aspeed_ast2700a2: Add
 AST2700 A2 EVB functional tests
Date: Thu, 12 Feb 2026 22:39:52 +0100
Message-ID: <20260212213955.2225662-14-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add functional coverage for the AST2700 A2 EVB machine by introducing
test cases that boot and validate an OpenBMC SDK v11.00 image on
"ast2700a2-evb".

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260211021527.119674-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/meson.build          |   2 +
 .../aarch64/test_aspeed_ast2700a2.py          | 190 ++++++++++++++++++
 2 files changed, 192 insertions(+)
 create mode 100755 tests/functional/aarch64/test_aspeed_ast2700a2.py

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index b5dd674bac61..49eca1205898 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -2,6 +2,7 @@
 
 test_aarch64_timeouts = {
   'aspeed_ast2700a1' : 600,
+  'aspeed_ast2700a2' : 600,
   'aspeed_ast2700fc' : 600,
   'device_passthrough' : 720,
   'imx8mp_evk' : 240,
@@ -24,6 +25,7 @@ tests_aarch64_system_quick = [
 
 tests_aarch64_system_thorough = [
   'aspeed_ast2700a1',
+  'aspeed_ast2700a2',
   'aspeed_ast2700fc',
   'device_passthrough',
   'hotplug_pci',
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
new file mode 100755
index 000000000000..e527518a5537
--- /dev/null
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
@@ -0,0 +1,190 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED SoCs with firmware
+#
+# Copyright (C) 2022 ASPEED Technology Inc
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+import os
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern, exec_command
+from qemu_test import exec_command_and_wait_for_pattern
+
+
+class AST2x00MachineSDK(QemuSystemTest):
+
+    def do_test_aarch64_aspeed_sdk_start(self, image, bus_id):
+        bus_str = str(bus_id)
+        self.require_netdev('user')
+        self.vm.set_console()
+        self.vm.add_args(
+            '-device',
+            f'tmp105,'
+            f'bus=aspeed.i2c.bus.{bus_str},'
+            f'address=0x4d,'
+            f'id=tmp-test-{bus_str}'
+        )
+        self.vm.add_args('-drive', 'file=' + image + ',if=mtd,format=raw',
+                         '-net', 'nic', '-net', 'user', '-snapshot')
+
+        self.vm.launch()
+
+    def verify_vbootrom_firmware_flow(self):
+        wait_for_console_pattern(self, 'Found valid caliptra flash image')
+        wait_for_console_pattern(self, 'Check flash image checksum')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Read abb header')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Read soc manifest')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Load atf image')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Load optee image')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Load uboot image')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Load ssp image')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Load tsp image')
+        wait_for_console_pattern(self, 'pass')
+        wait_for_console_pattern(self, 'Jumping to BL31 (Trusted Firmware-A)')
+
+    def enable_ast2700_pcie2(self):
+        wait_for_console_pattern(self, 'Hit any key to stop autoboot')
+        exec_command_and_wait_for_pattern(self, '\012', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'cp 100420000 403000000 900000', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'bootm start 403000000', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm loados', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm ramdisk', '=>')
+        exec_command_and_wait_for_pattern(self, 'bootm prep', '=>')
+        exec_command_and_wait_for_pattern(self,
+            'fdt set /soc@14000000/pcie@140d0000 status "okay"', '=>')
+        exec_command(self, 'bootm go')
+
+    def verify_openbmc_boot_start(self, enable_pcie=True):
+        wait_for_console_pattern(self, 'U-Boot 2023.10')
+        if enable_pcie:
+            self.enable_ast2700_pcie2()
+        wait_for_console_pattern(self, 'Linux version ')
+
+    def verify_openbmc_boot_and_login(self, name, enable_pcie=True):
+        self.verify_openbmc_boot_start(enable_pcie)
+
+        wait_for_console_pattern(self, f'{name} login:')
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, '0penBmc', f'root@{name}:~#')
+
+    ASSET_SDK_V1100_AST2700A2 = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-default-obmc.tar.gz',
+            'e2b8f043fe8063dd3b6ded93422e38bd41914dc9c3202199507652df024de4dc')
+
+    ASSET_SDK_V1100_AST2700A2_DCSCM = Asset(
+            'https://github.com/AspeedTech-BMC/openbmc/releases/download/v11.00/ast2700-dcscm-obmc.tar.gz',
+            '0e93f7976139da71fab9df7952a58bdd80650e23e7abf5853b0eb6695deb02d0')
+
+    def do_ast2700_i2c_test(self, bus_id):
+        bus_str = str(bus_id)
+        exec_command_and_wait_for_pattern(self,
+            'echo lm75 0x4d > '
+            f'/sys/class/i2c-dev/i2c-{bus_str}/device/new_device ',
+            f'i2c i2c-{bus_str}: new_device: Instantiated device lm75 at 0x4d')
+        exec_command_and_wait_for_pattern(self,
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_input',
+            '0')
+        self.vm.cmd('qom-set', path=f'/machine/peripheral/tmp-test-{bus_str}',
+                    property='temperature', value=18000)
+        exec_command_and_wait_for_pattern(self,
+            f'cat /sys/bus/i2c/devices/{bus_str}-004d/hwmon/hwmon*/temp1_input',
+            '18000')
+
+    def do_ast2700_pcie_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0002:00:00.0',
+            '0002:00:00.0 PCI bridge: '
+            'ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge')
+        exec_command_and_wait_for_pattern(self,
+            'lspci -s 0002:01:00.0',
+            '0002:01:00.0 Ethernet controller: '
+            'Intel Corporation 82574L Gigabit Network Connection')
+        exec_command_and_wait_for_pattern(self,
+            'ip addr show dev eth2',
+            'inet 10.0.2.15/24')
+
+    def start_ast2700_test(self, name, bus_id):
+        num_cpu = 4
+        load_images_list = [
+            {
+                'addr': '0x400000000',
+                'file': self.scratch_file(name, 'u-boot.bin')
+            },
+            {
+                'addr': '0x430000000',
+                'file': self.scratch_file(name, 'bl31.bin')
+            },
+            {
+                'addr': '0x430080000',
+                'file': self.scratch_file(name, 'optee', 'tee-raw.bin')
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
+        self.do_test_aarch64_aspeed_sdk_start(
+            self.scratch_file(name, 'image-bmc'), bus_id)
+
+    def start_ast2700_test_vbootrom(self, name, bus_id):
+        self.vm.add_args('-bios', 'ast27x0_bootrom.bin')
+        self.do_test_aarch64_aspeed_sdk_start(
+                self.scratch_file(name, 'image-bmc'), bus_id)
+
+    def test_aarch64_ast2700a2_evb_sdk_v11_00(self):
+        self.set_machine('ast2700a2-evb')
+        self.require_netdev('user')
+
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)
+        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
+        self.vm.add_args('-netdev', 'user,id=net1')
+        self.start_ast2700_test('ast2700-default', 1)
+        self.verify_openbmc_boot_and_login('ast2700-default')
+        self.do_ast2700_i2c_test(1)
+        self.do_ast2700_pcie_test()
+
+    def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_00(self):
+        self.set_machine('ast2700a2-evb')
+        self.require_netdev('user')
+
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2)
+        self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
+        self.vm.add_args('-netdev', 'user,id=net1')
+        self.start_ast2700_test_vbootrom('ast2700-default', 1)
+        self.verify_vbootrom_firmware_flow()
+        self.verify_openbmc_boot_start()
+
+    def test_aarch64_ast2700a2_evb_ioexp_v11_00(self):
+        self.set_machine('ast2700a2-evb')
+        self.require_netdev('user')
+
+        self.archive_extract(self.ASSET_SDK_V1100_AST2700A2_DCSCM)
+        self.vm.set_machine('ast2700a2-evb,fmc-model=w25q512jv')
+        self.vm.add_args('-device',
+                         'tmp105,bus=ioexp0.0,address=0x4d,id=tmp-test-16')
+        self.start_ast2700_test('ast2700-dcscm', 8)
+        self.verify_openbmc_boot_and_login('ast2700-dcscm', False)
+        self.do_ast2700_i2c_test(8)
+        self.do_ast2700_i2c_test(16)
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.53.0


