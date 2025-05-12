Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683F7C3ABD4
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEU4V-0001uO-If; Mon, 12 May 2025 10:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uEU4O-0001to-V7
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:23:53 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uEU4M-0006TF-PL
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:23:52 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so37976055e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747059828; x=1747664628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoyqA4/3ub1McfI/VtMSnnTsDusnutY8ftzaVytS2Ck=;
 b=YQ5LXyd0LYzq8InyvqXFq2RVKk+t9bD0F8xR25UvbY3l8jZrk/po4NWfkEZhi4Fe7H
 pgbB2Tesp1hmbM6SP91MVvKJ7X1Q4XzRUnhPWGCl7SknGACeGzmAlPSB50Qz0UtU6qX1
 VfdMW51u4atYOjLFco5lNvmi4WAkjFG1+CK4XF8zJFN7FBhb2AJSBXhDcHfGbstdBtIB
 gsBC5BlLX/paxf8RWS19ekZk5JcAnbpbYBOouxJ8Fce3oe6BsV28g3tYdVySc/okMx1H
 pymYKqHh3JHq2A3IUH3O/UHMHsalXngA3ycPGgxRKT8pPVmxtn0m+fPwRsVXxI2mJPbe
 napQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747059828; x=1747664628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZoyqA4/3ub1McfI/VtMSnnTsDusnutY8ftzaVytS2Ck=;
 b=QSXV6hGagJ76epEemVTD//tACh9PbIQwyuDAu+OG/MlaNLBQBu7vo1a+GA7xYs3Eqt
 IwXfZ77Stxy6A0R7+x3T/zjQNrTfYhie4Ht56m/0I0+GUmTeiorMoDpDR+Zxqm08SIYI
 GlIfdlR0ojsxlIGR8m9gc/z0rNKKkhuc9V69t4pxgQAueCpW+j5uqKGtFayayhAY5B3D
 lZsgTU/kQcMmkdvDFMGy7wJpcZHf4HRlImAj4STltN+AJTjOVi3xRIxP9p+iJ5vZ6s9h
 DqYxqY/shrk/5rLf53yQP8/cHilvaz+F+s49YM7qQIR1AdYs7P4vR+H8opUrkhjZlcwO
 rwKA==
X-Gm-Message-State: AOJu0YwCywNjqJrIhzjqWFhBRpWIeq9NlpEnU5xYr8tvkgbo5UrGlLs2
 sYb8JPKUWk+LqX0TJTL1cbVch792d5zoi7Du7p3trjwS7ZaD3yig0cekmc1nZUwaN9em3ekldWF
 5
X-Gm-Gg: ASbGncvSjxTFl/osPrVR7MIXIFfEfXfDL/Hox7IJd5t8KyfWZxmmGlv7L4/7vFty/ml
 76IF6gYsKoQpChq0qlQyqwjnR+BokZ6j+hcO326mSACojaT0gZIGop5JuBL68gFiF6KkHzDjU9S
 Ykvv27QKtWCk6qn5wlNF4NytVdUFZ5RHx8GJkXNnrYfBHqmNE/A2rsuj9+mOQ5ya3LAE3JPt09a
 3g/52pFpujRHdQ+HaQovwU9i3LxVPBfsCgIqGGtH1YHbHSuwxZ+fGxB0b3nBGrPhqlpBW9EZR9h
 bTIJ53N8gx7ACeOIf6RoKCWEabSiKDJ3/qTHg+3ev8wUKU8RziR2suh1psWT0w6F86P7YA2gCSG
 4sjwAR7PHar+xYxxpoGA7NeXeE8IRIU8z
X-Google-Smtp-Source: AGHT+IHGqCroQ3f4wU2wRmK1gSspBwzBJ7L9nIhkPWkDkHTsKZ1fvE+zD7CFJXEeKn3SRQgp09yexQ==
X-Received: by 2002:a05:6000:1888:b0:3a0:b8bd:608 with SMTP id
 ffacd0b85a97d-3a0b99076d7mr14483026f8f.7.1747059828354; 
 Mon, 12 May 2025 07:23:48 -0700 (PDT)
Received: from xps13.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3aeb6esm172597005e9.25.2025.05.12.07.23.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 07:23:47 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	thuth@redhat.com,
	berrange@redhat.com
Cc: gustavo.romero@linaro.org, eric.auger@redhat.com, alex.bennee@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v3] tests/functional: Add PCI hotplug test for aarch64
Date: Mon, 12 May 2025 15:23:25 +0100
Message-ID: <20250512142336.181080-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x330.google.com
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
hot-unplug on arm64.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 MAINTAINERS                                  |  5 ++
 tests/functional/meson.build                 |  1 +
 tests/functional/test_aarch64_hotplug_pci.py | 72 ++++++++++++++++++++
 3 files changed, 78 insertions(+)
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
index 0000000000..f4a05de39e
--- /dev/null
+++ b/tests/functional/test_aarch64_hotplug_pci.py
@@ -0,0 +1,72 @@
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
+                         'console=ttyAMA0,115200 init=/bin/sh')
+        self.vm.add_args('-device',
+                         'pcie-root-port,bus=pcie.0,chassis=1,slot=1,id=pcie.1')
+        self.vm.add_args('-bios', self.build_file('pc-bios',
+                                                  'edk2-aarch64-code.fd'))
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


