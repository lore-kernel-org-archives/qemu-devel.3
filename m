Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C7DC3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 23:23:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDX2t-0005gC-Le; Fri, 09 May 2025 19:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uDX2q-0005f5-9T
 for qemu-devel@nongnu.org; Fri, 09 May 2025 19:22:20 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uDX2o-0001g3-7w
 for qemu-devel@nongnu.org; Fri, 09 May 2025 19:22:20 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so18844155e9.1
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 16:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746832935; x=1747437735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KNebfU43VSOUKHTi8HcTmDrrW5ku/A+6mFFMSy02Tj8=;
 b=HjUwzz0D5MpDl1neySq7za+b+P5lzvXD20lAlVtzj74ItXu9Y9THH59TwSKG4DlvxN
 wEUqctLLh2DsgIdaH0FdaH8wceLD4qc7oJQQXXILZhBxuVXMekYOEfjyDbkTz0YLLlcj
 +y7qE7QBCA36EjvekjVAmoxGepOTfuUo5j959nNVBzyWAEwmJFNN6ZjLbYP2OlHoUeDa
 vl5uu4gCkzNWrj6kDl5BWYuCl2u2KQxzUwhcvcom00hyPUtCHLSD9SgUH/gDmQwPVrn4
 vEzrylC5fKwikNVaAOJv4l60BYCpaVZ25PRfT8/HBz3xIrZmsPRT2yoVBAcJkoH7GfkO
 YiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746832935; x=1747437735;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KNebfU43VSOUKHTi8HcTmDrrW5ku/A+6mFFMSy02Tj8=;
 b=dKIL/yLD/0Ot3FDWMFhhVhXKrDqJRNjkmEmiiOfTkvBcU2JEJ8U767+6cuJlRe30Rz
 QbM/Ki93DE/VEsleEUk5RwkXsX8lTt0V0haMdjW/zhxkxVQRrwsg06WqpJGeGUOBU76Q
 HYrCrtcFIUPUMcgLQ0XDGF8aEt27elQO/PKBq/IpzonkNEHtoApztLqWfm0YHqASmMGW
 8u2oEcQo/daKRIoUh4ftHgqlxI9VcpInSZA/h/ii9rc7Kx5QFvtpgtbZXcDXRguD3gYP
 DL/lm1fZK/8JiTOJBEbGwaHdMefIssJDnkKOhgAD2Xmccou95g9rVHzAfnKsPPeWeUNG
 lt1g==
X-Gm-Message-State: AOJu0YzvhHZAbFZlbDzBz9Uf0Mfi3utiYKxm2oyw9K2PON8L4XMUo4+G
 sY8Q0y/B3MbQldkFfrKapSQZ/mJ2gRIDBpWR7+qyXeNlCA3OIvqxwZXlGdANl5nPPV/BxjebQOy
 T
X-Gm-Gg: ASbGncvQ+j9wyw087DRUfi7REgnX3l/pgP5ErGPucV2MuvLrPR0QO1c0zgTDTNqgLdQ
 NPhcWQm+SQEEcU0OsiDSMa7NSc0Q6OmY8B5WL2C7QAxwvtzyltXwQughoz94Bh/FZ68vjsgu4Zc
 IRVCyuwxLIRzuMac4N59u393JkUioHsI2K4bHVDj2jv5nfmslF0rgOACdJlAOTFsGxB5k5/GI7c
 UvKJGudpAs1bewbGPakeTbvT51JPUJ3LVXbiDS/3TkgaGokTYCqx3elmjd3qVyVxEJ+mod2PaJJ
 CF5lDiyxVGk2h6yqhJkiKRwaHBll9A3kTFh4rICq3P2EcXkOZm1xgzLvK31tdIVdph2CFkiOD1n
 b6Og9rBIYVLssoSg=
X-Google-Smtp-Source: AGHT+IGdI8DlXUId+tkLaKqwFYXa7GPRfRkBoJYvsqtvfuXabQpGmOO03ei8BwoS6P+oDwn8JX/ZWQ==
X-Received: by 2002:a05:600c:4451:b0:43d:526:e0ce with SMTP id
 5b1f17b1804b1-442d6dc51e8mr36999685e9.21.1746832935514; 
 Fri, 09 May 2025 16:22:15 -0700 (PDT)
Received: from xps13.. (83.69.114.89.rev.vodafone.pt. [89.114.69.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d687bdcbsm44407045e9.40.2025.05.09.16.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 May 2025 16:22:14 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: gustavo.romero@linaro.org, eric.auger@redhat.com, alex.bennee@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org
Subject: [PATCH] tests/functional: Add PCI hotplug test for aarch64
Date: Sat, 10 May 2025 00:19:58 +0100
Message-ID: <20250509232156.106465-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x335.google.com
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

Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
native controller and does not support ACPI-based hotplugging. However,
since support is planned, this test sets 'acpi=force' and specifies an
EDK2 firmware image in advance. This is harmless and prepares for future
ACPI support.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 tests/functional/meson.build                 |  1 +
 tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/functional/test_aarch64_hotplug_pci.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 52b4706cfe..2d68840fa2 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -83,6 +83,7 @@ tests_aarch64_system_quick = [
 tests_aarch64_system_thorough = [
   'aarch64_aspeed_ast2700',
   'aarch64_aspeed_ast2700fc',
+  'aarch64_hotplug_pci',
   'aarch64_imx8mp_evk',
   'aarch64_raspi3',
   'aarch64_raspi4',
diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
new file mode 100755
index 0000000000..031540ba22
--- /dev/null
+++ b/tests/functional/test_aarch64_hotplug_pci.py
@@ -0,0 +1,73 @@
+#!/usr/bin/env python3
+#
+# The test hotplugs a PCI device and checks it on a Linux guest.
+#
+# Copyright (c) 2025 Linaro Ltd.
+#
+# Author:
+#  Gustavo Romero <gustavo.romero@linaro.org>
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or
+# later.  See the COPYING file in the top-level directory.
+
+from os import path
+from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import BUILD_DIR
+
+class HotplugPCI(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
+         'current/images/netboot/debian-installer/arm64/linux'),
+        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
+
+    ASSET_INITRD = Asset(
+        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
+         'current/images/netboot/debian-installer/arm64/initrd.gz'),
+        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
+
+    def test_hotplug_pci(self):
+
+        self.vm.add_args('-m', '512M')
+        self.vm.add_args('-machine', 'type=virt')
+        self.vm.add_args('-cpu', 'cortex-a57')
+        self.vm.add_args('-append',
+                         'console=ttyAMA0,115200 acpi=force init=/bin/sh')
+        self.vm.add_args('-device',
+                         'pcie-root-port,bus=pcie.0,chassis=1,slot=1,id=pcie.1')
+        self.vm.add_args('-bios', path.join(BUILD_DIR, 'pc-bios',
+                         'edk2-aarch64-code.fd'))
+
+        # BusyBox prompt
+        prompt = "~ #"
+        self.launch_kernel(self.ASSET_KERNEL.fetch(),
+                           self.ASSET_INITRD.fetch(),
+                           wait_for=prompt)
+
+        # Check for initial state: 2 network adapters, lo and enp0s1.
+        exec_command_and_wait_for_pattern(self,
+                                          'ls -l /sys/class/net | wc -l',
+                                          '2')
+
+        # Hotplug one network adapter to the root port, i.e. pcie.1 bus.
+        self.vm.cmd('device_add',
+                    driver='virtio-net-pci',
+                    bus='pcie.1',
+                    addr=0,
+                    id='na')
+        # Wait for the kernel to recognize the new device.
+        self.wait_for_console_pattern('virtio-pci')
+        self.wait_for_console_pattern('virtio_net')
+
+        # Check if there is a new network adapter.
+        exec_command_and_wait_for_pattern(self,
+                                          'ls -l /sys/class/net | wc -l',
+                                          '3')
+
+        self.vm.cmd('device_del', id='na')
+        exec_command_and_wait_for_pattern(self,
+                                          'ls -l /sys/class/net | wc -l',
+                                          '2')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.43.0


