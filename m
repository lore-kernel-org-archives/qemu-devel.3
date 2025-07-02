Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812D0C8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 10:52:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWv2b-00007X-EI; Wed, 02 Jul 2025 06:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2U-0008VH-QT
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:07 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uWv2O-0002o0-05
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 06:50:06 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso44870125e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751453397; x=1752058197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQDGpu2DK2e5jYtAk3+B2u316yUnK6jEtaDaYh1M9uM=;
 b=uxOw+j9FukRiZox/oJAjeEbWyyvyy7IoG3kz8lwEnPE9Adagw+QY21HhdaiBMUVPf6
 rSKj/vwL3UepZnLmyt1xU2ujHt3urGBDYx7aiOLS4W0xshV2+QdGlZPfMvbXQYHQ6d/A
 /Fi+VJVtu5EPGGihZYKh50IlRO0JB4pz9YbcmT3qaSk5ubiApenpZG2SrLmT2HhAlk8v
 ZJM8LyGv6FC5aqC3zzSZig8yi0uCROBUzTh52aGa4IMA1G9B0hPMMo/dumd57iEv7OIC
 ZmIIE/rYuOMx+csixFdQ6QbIjd6GKEySxiAaZo9jYcPmMz0jGfYTst5/chP6XR7RXQVg
 VQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751453397; x=1752058197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQDGpu2DK2e5jYtAk3+B2u316yUnK6jEtaDaYh1M9uM=;
 b=FpXnptgTgo0cjaqRae6d4HVlL9haF8zSHCgJmqHX74k7c0nhkWCLtveybx+nspo8pg
 xGQjQ368iwTlotilD1wa8ZntG8gTvOhHxRS5EtMPqeGDRSgwv2mCrnFHLR1cXaNRSO0L
 LgUbRHoZLa+fZw6hAUbcrS+ucDaJsl3UHzzRHqZ8oUL6YpijIcPlr3bjZ6+NPxBK35ep
 I4lcLTI+dstf4AepcmesigoUB9dGXiuVQ16kGw0st8XFSrv7sTV4UT5YB4pbnGUitrqi
 vOOWyIchYqfKVDIiQMenytt2MN/K+UyAUjxpzNwUDbNN6uytyeFAPhSeiiK64FYWuqA8
 nBGA==
X-Gm-Message-State: AOJu0Yxn/sD8DcU5hU6MzcTlaMx1Is1BcFlcWNi0IK8LnzuZsdcsA++D
 /T3klgvVifXt6hWyWSqr8kopoQbvhKnjy6suQd8u0Nmh+jmQpHX+Um/dSTvqZj4ja2U=
X-Gm-Gg: ASbGnctzgDCq6W/nLku6FgEoegvOu7wY//6L0vvnSqxnvZCRuIp+OddqhofkcBC+FV/
 RISo2KgIrjDhbUaTyWODylEp17ek2PkE2/x67OtOhXU1LirzsR2OWhJlJuSaNITCmZsI0UJZuDz
 7qu8dVvPK+KHSW6SdfYdu+GBCnKvBWqo+Ny4/04S5w0+9PlpXppnegY0L8uacaklNqVHCDpEvLC
 //7Z2wWuYN+w77xUiGUrsaYBAK3fvXhqOqSA1Z5U7yNQ0vzbEovC9KlgiRr2tK/B6qbPBeA5GR1
 l6XzbzuhDX9xq/aOowHhYtAXDQ48IUOh+RME1GRXVIxyQEWcZGovrk7Q7E4/mkg=
X-Google-Smtp-Source: AGHT+IG35Lq9GVUwjVqutJmVlIZPd4qpsF9g4eWdlLENhMgRhfxJh0ha/WjnxOIkNpjyjbTJzsb4BQ==
X-Received: by 2002:a05:600c:609a:b0:453:10c1:cb21 with SMTP id
 5b1f17b1804b1-454a3c25487mr24137365e9.8.1751453397516; 
 Wed, 02 Jul 2025 03:49:57 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7fb67dsm16071010f8f.35.2025.07.02.03.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 03:49:56 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F097C5F8D6;
 Wed, 02 Jul 2025 11:49:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM PCI Hotplug)
Subject: [PULL 02/15] tests/functional: Add PCI hotplug test for aarch64
Date: Wed,  2 Jul 2025 11:49:42 +0100
Message-ID: <20250702104955.3778269-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702104955.3778269-1-alex.bennee@linaro.org>
References: <20250702104955.3778269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


