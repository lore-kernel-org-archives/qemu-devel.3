Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 424D4C83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:46:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWuwO-0006dD-Kk; Wed, 02 Jul 2025 06:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwM-0006cv-UM
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:47 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWuwI-0001IU-4Q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:43:46 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-60bf5a08729so8793195a12.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453019; x=1752057819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQDGpu2DK2e5jYtAk3+B2u316yUnK6jEtaDaYh1M9uM=;
 b=xu8lbEXdQdC/vuPNdP6cvlETjepLf0GzjgG65Aa6y+Vl4M9MPU0J3UzQv/Yq3W+/DF
 oHwrGBw3dR3VMzwReVieLSQhhriwNqHrR9UkLSxb4ECJ/lVHn3ajyIMV7NZdjO9hcrC/
 D7FyIImelv1YsgctYwrNL25araUgx2a9cdPYIAscD8Pv9sUFAm7+9Rki7xjjF97mKm/t
 utvRygeyg9jBwAALpuH+UEXe7js/Z2Soe9F/BW4/NP1Gs0Iv+3nMNT6Xj1aASnl/in0d
 aOrAdjtnmVVkrMa3FubbLOKNA2gc8Wm/3jA9cQ7ayBdnOmGynjhGAnsYzm20gJeEFaBd
 d0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453019; x=1752057819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQDGpu2DK2e5jYtAk3+B2u316yUnK6jEtaDaYh1M9uM=;
 b=PD1oC68GmSlnxJHF2bHVgZN//QkKGVRqMVuyxH7qvSmB9rWqbxIWB9mV0QFY8727c4
 0c5eaTMDeiCJMQ+xyelPLUCiprvxsivfIwAuIlQ06EptmE+UB1OdYhzrqSejVVhvfRk6
 ks2NFItj23xUnpPZh/K6VPpUaW1eUqwe1cjiwhTGFtqMVX7Xp4X2ObNCvSj8u2jYALCX
 78VLDAM14E6tGT4spXs8IUdpoP0qdSxnoeO19uRuT93X1S4U0G5MuPNGVC2Ut+DSqSM1
 PR7V6C54YOxMeHpxlw4Q3L0n2c5mabHbIcGwdwUCVpDC+Z3mYtyG1u/oYoSAKIOBxW/K
 esjg==
X-Gm-Message-State: AOJu0YxYBa0F4rvUPzKxpZZrUHoqNDvmgny5Kbi4ge/VCZ5gfF22NMLZ
 Hw9wVcXi7pE25cemg83Q9AEvH+qhr8wlRfY4uGJBvn9YT40RDI/cayfNtKO+oI+LX66jq5jQ+wS
 kiHb5eFE=
X-Gm-Gg: ASbGncsJkF+e73WETLo8/x/CKFry3eG0JUSeEqZLw/eqxAIZQxfpyj0VYz2FgzjIwAe
 aQu/gN8bXezfQeJ3gonLUxAmXLmjyOeIkI+2gxLp/bGj0hCt6gbqKEmCXKa7F7rx6ncYYJ2rMmn
 8LSc8SrQpYX//GT62GWXq0NHo8S5qu88nZFE8cZzVUvFVeYxqugwZIbwuBfiXCW35iQpOsS379J
 ZXjgrKnfefekNAllGECEx6cT+J54kMit+n0Bd4EtXTKCCzTUXGsMV7Vruwq+L2ckS80QtIcJw/x
 N+JD6VFpTpxAf8xy76bFrm5H5XyPxu87h4orXnOz18ZQyiaIYz+iFOPOi8pMdE8=
X-Google-Smtp-Source: AGHT+IG5og/5E02tihARqc9HyJXY3wkpj6R46Fll9yI854HL55n8yzIa/O8HY0AqHuDJj/oUnYkgOg==
X-Received: by 2002:a05:6402:354b:b0:608:493a:cccf with SMTP id
 4fb4d7f45d1cf-60e52e3be80mr2052923a12.30.1751453018991; 
 Wed, 02 Jul 2025 03:43:38 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60e26b7ac4esm3334924a12.7.2025.07.02.03.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:43:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EBD875F8D6;
 Wed, 02 Jul 2025 11:43:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM PCI Hotplug)
Subject: [PULL 02/15] tests/functional: Add PCI hotplug test for aarch64
Date: Wed,  2 Jul 2025 11:43:23 +0100
Message-ID: <20250702104336.3775206-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104336.3775206-1-alex.bennee@linaro.org>
References: <20250702104336.3775206-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
hot-unplug on arm64.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250528203137.1654964-1-gustavo.romero@linaro.org>
[AJB: trimmed boilerplate for checkpatch, simplified invocations]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250627112512.1880708-3-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index d1672fda8d..850588fb64 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2089,6 +2089,12 @@ S: Supported
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
index e9f19d54a2..53721c97ec 100644
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
index 0000000000..c9bb7f1d97
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
+# SPDX-License-Identifier: GPL-2.0-or-later
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
+
+        self.vm.add_args('-m', '512M',
+                         '-cpu', 'cortex-a57',
+                         '-append',
+                         'console=ttyAMA0,115200 init=/bin/sh',
+                         '-device',
+                         'pcie-root-port,bus=pcie.0,chassis=1,slot=1,id=pcie.1',
+                         '-bios',
+                         self.build_file('pc-bios', 'edk2-aarch64-code.fd'))
+
+        # BusyBox prompt
+        prompt = "~ #"
+        self.launch_kernel(self.ASSET_KERNEL.fetch(),
+                           self.ASSET_INITRD.fetch(),
+                           wait_for=prompt)
+
+        # Check for initial state: 2 network adapters, lo and enp0s1.
+        exec_command_and_wait_for_pattern(self,
+                                          'ls /sys/class/net | wc -l',
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
+                                          'ls /sys/class/net | wc -l',
+                                          '3')
+
+        self.vm.cmd('device_del', id='na')
+        exec_command_and_wait_for_pattern(self,
+                                          'ls /sys/class/net | wc -l',
+                                          '2')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.47.2


