Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B508C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 20:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKNRZ-0001f0-FR; Wed, 28 May 2025 16:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uKNRV-0001eB-Q9
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:32:06 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uKNRO-0001sP-64
 for qemu-devel@nongnu.org; Wed, 28 May 2025 16:32:02 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-527b70bd90dso59964e0c.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 13:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748464315; x=1749069115; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jXTDwR7pk9WsuiUd+vIU5n7dRKgQi6hQX7UWMGnJ2vY=;
 b=RsVg8SBTCbCYR7nVIkEnkwzmcEnxjOHUzpQN3sKyeKWxCG+N3Dh6RpFff8mdOQHuYP
 1fovceEn7jvAhbmM3PbUuG4bqk2V46z4rKPDsVqcV4BKOpksscwsej++gy7WCzFbtTS2
 VllVkKLzXjT1eLSmAmYRvZO19IuAEr0tSvHeMX2eV5tEsUxvyHML6E93qZ3ZiQ6Whwmj
 GGPG+ZLNZEHyrqF2vgDnvia0mCSNXjGvpLHeQpHnfp+8+KkZ5uHv3lboOyqAAmEgVQWb
 kcWF3g18bk/0HZgrgfnI50mFE6SsjjPIivuPe0LaiC14N4wJSFiWpypRr1u3mzBuQudv
 aBmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748464315; x=1749069115;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jXTDwR7pk9WsuiUd+vIU5n7dRKgQi6hQX7UWMGnJ2vY=;
 b=arKxxqDORVLw01vGX67aiSdWf8JdGlImXGiUjaA8QOEN6SXtsUfqS+TiM9F0LLleUw
 4nVZIEq51gv0rQFZxCiXyie8A58c5aSbvVv1t05bCWjeUhgdjtkwuIrkxsb9aDFrw8jU
 cW3wM224Be0IUSQaoGu7Mdt3K2QtJ2y+JhRfb0hzsJQfBEQkQ+4ifaTAxQygPlgQ95Ih
 esoM2BtYXJQm4aamEnPZHq4n4XaZ47nX6OaREAbD3snNW5cYwLzKXLXTG/pW6DNfJCbR
 FCfTaSFJzet5cxdNkX1xIb25bxwJO1py80WQGdCpzPEqvSDklKKZdKsQoJaZES/7Q0cI
 Wczw==
X-Gm-Message-State: AOJu0Yx6XrycpzIyGlydddg5w0kp4l7yHqLL6xPMctpAI67bIEtmSXPY
 iBsXnNoSI1ta2L5xvcolijbo4edCfOSjM/MsSaiHKBPKc+bvcnb4WPMPA44hwS7Qr84MjWepuAL
 mG0qx
X-Gm-Gg: ASbGncub/F2o9Pvt/ueiAXFCohTP93imafUlPsHtpMuvjzyzAE+eQmlIBk6vwrxsAK8
 7mDWMR78H3sluFJGNKMTI1uJuDWuAXmRtDigotWusxe3zDYoWbURDaQtdwr7voAp53onYIpdeTO
 wURdTTscs1i9SOtEYQcUb89LGTvd0qWOmjXvi0dqtWJ4yAF6z33PXfd1vzHTlmR9qGoySr2clDo
 2FscAJd2N40MWODGkdGok9aoNd2dwzzHDhyvP6j8h0wHgvrqVZUvBwjkdJQIdFHgGju359azP+0
 GyDCcRa4slcYrXlykJatiJm7hr+KJ2wYfsTvsMro6YWqaeRwqrzIgeyWa01zLwo4+z/vSca3JG5
 WKva2VnvVQBqMpe2xxh6nW9I9UqnWoYvN
X-Google-Smtp-Source: AGHT+IH7+pdPVUVbM+DljZpA4XTau9zkPij4FNcTrJoI3xLHYDK2UX4Sn8A6fU+T0yZ4xBnk6pYiGA==
X-Received: by 2002:a05:6122:a23:b0:520:3536:feb5 with SMTP id
 71dfb90a1353d-52f2c5ab85emr15703239e0c.11.1748464315489; 
 Wed, 28 May 2025 13:31:55 -0700 (PDT)
Received: from gromero0.. (200-100-75-183.dial-up.telesp.net.br.
 [200.100.75.183]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53066864d8esm1773050e0c.20.2025.05.28.13.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 13:31:54 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	alex.bennee@linaro.org
Cc: qemu-arm@nongnu.org, thuth@redhat.com, gustavo.romero@linaro.org,
 eric.auger@redhat.com, berrange@redhat.com
Subject: [PATCH v5] tests/functional: Add PCI hotplug test for aarch64
Date: Wed, 28 May 2025 20:31:37 +0000
Message-Id: <20250528203137.1654964-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=gustavo.romero@linaro.org; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                  |  6 ++
 tests/functional/meson.build                 |  1 +
 tests/functional/test_aarch64_hotplug_pci.py | 74 ++++++++++++++++++++
 3 files changed, 81 insertions(+)
 create mode 100755 tests/functional/test_aarch64_hotplug_pci.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 7060cf49b9..818d7b9d5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2078,6 +2078,12 @@ S: Supported
 F: include/hw/pci/pcie_doe.h
 F: hw/pci/pcie_doe.c
 
+ARM PCI Hotplug
+M: Gustavo Romero <gustavo.romero@linaro.org>
+L: qemu-arm@nongnu.org
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
index 0000000000..2cf5c28b9f
--- /dev/null
+++ b/tests/functional/test_aarch64_hotplug_pci.py
@@ -0,0 +1,74 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
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
+         '20230607+deb12u11/images/netboot/debian-installer/arm64/linux'),
+         'd92a60392ce1e379ca198a1a820899f8f0d39a62d047c41ab79492f81541a9d9')
+
+    ASSET_INITRD = Asset(
+        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
+         '20230607+deb12u11/images/netboot/debian-installer/arm64/initrd.gz'),
+         '9f817f76951f3237bca8216bee35267bfb826815687f4b2fcdd5e6c2a917790c')
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
2.34.1


