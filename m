Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EBEC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:37:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESPA-0000Lt-PH; Mon, 12 May 2025 08:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uESP7-0000LZ-33
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:37:09 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uESP4-00043F-2P
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:37:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so31607175e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747053420; x=1747658220; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lvj1uROfLn32JLAjyn9W1xGqdebHa/XcCRD3Gi/f+Yw=;
 b=pdlR0xQ2PwgFD662tXAtSuundyp2db/qHg5lUjzdhBtZ5O00r0FE1bez5r700qZ25g
 wv9B8lHAVYvYQc1x6acIKKCLhq1ev/ivBqmAkNJn/zTKIsBIBCe5sagHNN3oAWm+xkjw
 8yDTcxc232Zg7VW6BKFTwKrGofvGXzSMoh1emuNLg68XM8xisKxEZLTJsyyoI0RzIKMc
 uBODjjRokmpI4CPa4GRXAipCNYMfj7aW1OwGiexhTxlQHPcsvDFGXzhhkEop6MG7UqVW
 KgjumS0/J01yx7JxOgooyIjuZYP0RrHR9oGLDn441B7Xm9MwzPLcTSHKeKSCW7+dBnI1
 pT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747053420; x=1747658220;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lvj1uROfLn32JLAjyn9W1xGqdebHa/XcCRD3Gi/f+Yw=;
 b=lPTeaAzJ8vcyYgGDFxT8avR6mz9O3Gi3qzb90zAKhucxIj2pYD7P9DJSBO+y5PBA2Q
 XAJbNaiCuxPHnRwXh7kk6sN5lgsXBBdx3yNO+oe0hB4j3JV7zmXwLLH5ZPwAeRUDhMGQ
 V3HraquYRn/tBXezjdMWlwI88ZJ++aoxY1+3/RsUFrFeQYGvzTXrr16jnkOLYix/2RdT
 kyJs+MHAHS75fmtuMp1ydoRZvsJ71VMjRcL+dT2x69P/bCVmnkW4mqoN6UoeAI1PNngh
 zSvx214Kt05gNkxp3XIpHPwEF42F6EuiV1A9LHElofmMDRWrW9gfmZXQZt0sKx1o2mnK
 I7qA==
X-Gm-Message-State: AOJu0YwCCGnGtK0N7BSRPDpO6COKgLTqwZLLidsaZMT3pj5xVAk9c/nt
 GO3mxMFbFSdjiKMynFiweKTwju9Zi6Di4vUbVavyRreVj59F5Q88wyYHVi12ez9ZZFJux/AohIR
 +
X-Gm-Gg: ASbGncvcKisk2BKdwKY+ibELvhUyWCzCMtHidCUFcKLCpELkdA4U3TOUHDW8eOVwYZh
 Gu5fVCAjtLkX1HqBtiiFfKy0lv8HU7L/e2XCyyCkcIJRGEwq81AjQgkUCwhsTn4xRBhzqWK3Ufb
 qFGD23XrhqFWWCWdFGP9CkyJIpk9ZvELHQ1Khz6IYP5ZRhdx/l8SZZddM4zmvIh6bpf/m/ViNrV
 01PTOIcmmkZ4Jsntk+XArKosbwPyR3KDUcD4n0NQz+6WTlBu7xIIbsNr9cAngfcSuIMIJrqY8WR
 Kl5KszMbMiGxy5r1TAFuFmJXEtXff3Lc/heyflhanAT/CADk0kYgWmjLLbxth7fhSkRpNJHMjtZ
 UZ3MXKus2xLlW/UxVmGAMvwG3vwQxpU11
X-Google-Smtp-Source: AGHT+IH4UCD0hd7YG7Rtb1Av6cuo+XXN5khHTwG1noyQFpXQylPMyOhJSLoAxinrROhCx5wI/Mt/ew==
X-Received: by 2002:a05:600c:a110:b0:442:d9fb:d9f1 with SMTP id
 5b1f17b1804b1-442d9fbea9amr76690765e9.4.1747053420075; 
 Mon, 12 May 2025 05:37:00 -0700 (PDT)
Received: from xps13.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d685869csm127517065e9.26.2025.05.12.05.36.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 05:36:58 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	thuth@redhat.com
Cc: gustavo.romero@linaro.org, eric.auger@redhat.com, alex.bennee@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org
Subject: [PATCH v2] tests/functional: Add PCI hotplug test for aarch64
Date: Mon, 12 May 2025 13:36:33 +0100
Message-ID: <20250512123646.157447-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x32d.google.com
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
 MAINTAINERS                                  |  5 ++
 tests/functional/meson.build                 |  1 +
 tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100755 tests/functional/test_aarch64_hotplug_pci.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 23174b4ca7..9ebb768214 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2065,6 +2065,11 @@ S: Supported
 F: include/hw/pci/pcie_doe.h
 F: hw/pci/pcie_doe.c
 
+ARM PCI Hotplug
+M: Gustavo Romero <gustavo.romero@linaro.org>
+S: Supported
+F: tests/functional/test_aarch64_hotplug_pci.py
+
 ACPI/SMBIOS
 M: Michael S. Tsirkin <mst@redhat.com>
 M: Igor Mammedov <imammedo@redhat.com>
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
index 0000000000..05c92d7a45
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
+        self.set_machine('virt')
+        self.vm.add_args('-m', '512M')
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


