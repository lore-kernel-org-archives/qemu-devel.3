Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38F6EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEUQi-0006tn-RN; Mon, 12 May 2025 10:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uEUQa-0006n3-Qk
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:46:51 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uEUQY-0000xp-Db
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:46:48 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-440685d6afcso51100215e9.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 07:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747061204; x=1747666004; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YdI+i4zev0OQ7/OBo6IO5PLh4ziQxP2ot1AsLf6mhbc=;
 b=JQi16qP1PYx9ASsCMR0/XO1FRVZdUwlwtNJwVthAxplWfRn1Sid5VyFwOMBFxcgwLf
 H4MwXMS92JgW9odbxRkCgs1KQBmgyFwa8MknOINVkDI5wPmMaTMI7X5sqO+qAGAudSK3
 MkxqCncOFYoz8sBU4fV/gZ2eRLVZGAwdVvQtDZd+fowsIUSpIprffrZsFlGal3aJ3r8D
 8DdAXenhxlIMuMS/GgLkYpIseaZOKZTCffEjknKPMEUZWSS4Xs6pDNzuZU9UrdQhwBYg
 kSeHc6MRtdxPJkD2HIyBAA9JsU9LAaNVAt/cgaAvQEZBfzT8m5ptFG+qBGQxdagCNs7S
 3/OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747061204; x=1747666004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdI+i4zev0OQ7/OBo6IO5PLh4ziQxP2ot1AsLf6mhbc=;
 b=fDefRHMm8fx8sBXwu6qayRDB9dfbkRyyAz5Rx/1cEueu4j3tFot0C+plMpUd4MfDX0
 OcqMSBAzbfgIsS2ipwlw5W/0PQ5KKZW8MY0lSRlDQCHeJl4tZkTDXYrQkTCkatu30VNe
 RgV3/y5FbssKZ0rm8NulwAAV4AsIrevKnHjnUmqmRQ+bQ2PU4J4uOu2Hkc5Wgskxm2BY
 sHQYrs3MXQqtV46t6XMsm63sKySRGFLXwvwHgoBEpxYdQ1S8BdzFLcpAa7rpmFGG87qH
 8NHfiJENl6JtlHbbfTs/00Mg0DkeibVRmBHWsUHwq8udjczQhtzpvvZrRXbauUvgyjiY
 K/zQ==
X-Gm-Message-State: AOJu0YzB4PTdn4oX0+x/4MdbqNDPRiWJkuiSADNpWs87wpoiifThGv8P
 ZRbUA5GFS3zXlXTIttH5boND2jjzLywh0CNVJBs98O5r75/ANrCySXvztAms7+BnCNULs9k016F
 1
X-Gm-Gg: ASbGncuP6ggnC4rWJdPZ2RTBE2qxo0izc7TeDWtYeJG4vbfwgu82IL3sQzl4r67m8ul
 Bqytjy7Rfykd42nYnN6KZli+JXkOfenyqw0l7eYZgvBkLJHwdf3u+mtYScAJAdykuQLTvaW0oBH
 Vkzpdtubq8TjLtCDfDlQAjekKDrsmiCIxUMRkBNdiZ2s+RSkXX9A/Ytj3OIk4s7OOjdlte2Pa6h
 /n4C5eibhESiVEmily9Y9LlCcSzIkTcRMPUma6z4STuZQaVebinPRiRpPHFbpA9apbUBFwk1r3k
 4H3H+5CAsBVdK75vQC6AchuOTupySWmONwGvOF33dqLW/xaV582vpE/SH5t+AeXTynRi3k9N52B
 ubOamrsQzHflN6aT6v6eD1D4U5fZZq2k7
X-Google-Smtp-Source: AGHT+IEJcNtepBTtSyidNPWfopTkNDkFWovfT5ZLmLhkGXOvIk00cQ0ltg5PYK7+UFqsTiggrnU14w==
X-Received: by 2002:a05:600c:3b84:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-442d6d44b30mr120675365e9.14.1747061204308; 
 Mon, 12 May 2025 07:46:44 -0700 (PDT)
Received: from xps13.c.hoisthospitality.com (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d68585d1sm129173445e9.31.2025.05.12.07.46.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 07:46:43 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	thuth@redhat.com,
	berrange@redhat.com
Cc: gustavo.romero@linaro.org, eric.auger@redhat.com, alex.bennee@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, qemu-arm@nongnu.org
Subject: [PATCH v4] tests/functional: Add PCI hotplug test for aarch64
Date: Mon, 12 May 2025 15:45:45 +0100
Message-ID: <20250512144629.182340-1-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
---
 MAINTAINERS                                  |  5 ++
 tests/functional/meson.build                 |  1 +
 tests/functional/test_aarch64_hotplug_pci.py | 74 ++++++++++++++++++++
 3 files changed, 80 insertions(+)
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
index 0000000000..fa1bb62c8f
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


