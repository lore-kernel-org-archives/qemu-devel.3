Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8141C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:28:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7D0-00056E-Vu; Fri, 27 Jun 2025 07:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7Cr-00055J-7k
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:21 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7Cn-00077Y-2W
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-450cfb79177so11250665e9.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023515; x=1751628315; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86d2/oAIEj3do6T300sHlZkco6pyNAgZUSH9/1Z5+kc=;
 b=qOgshlpv6em4iiXGxlgdhbI4+75yyk0JuJpNXj8JlRmZeot8l5HFLCmr2kLCuE6U4z
 x6iP3qBbb071sGpz1hRm3mVh1mtXUmTpLpJARrKcU3qSYOjzjn7KS8LJrX6Rd7GbZy+3
 Y2CfM4uWYmTJPb8Th7W0iWWOXu2Yy80HISXmScevcclyh7uVn38HHrjvr+OsAZCClLaF
 GxIow+PansuaD1OQVLnOda8XRLgJZ6OC9kPlH8jo0JD4VexTnEszNT+yH5iLrSdLjUMf
 DId1G8J2leyLY2roSl/vEKlo+8Mrh0njlHY86YOeE0S16QNWuplI4kbGAnFmURVQHOa6
 HZCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023515; x=1751628315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86d2/oAIEj3do6T300sHlZkco6pyNAgZUSH9/1Z5+kc=;
 b=jGgogUZsLj+Ta24762cCqW5jZSUZ/rA2Uq6rYMcoxU+wvjBKvaD6o1AKAEqlVufYtR
 eixhVjCB1Z5IJ1Q89Lzyyla4nUie34q9GfKA23mwnK3QhHL8nDB4WItUOxD2sDCUAxRc
 /yhdMkjINq3YknKpUL68AY5TwdiDpJSdlzGA2/4/NyvUbq98yJqnfBdpjKA4i3xFhHu/
 PlLdOHq2HM0vYjkMD/Gt5OXJzXmQlbaUcDmYtkHdsizhofUqDht6PUrlu1TfCNvxufRE
 nRNCSztK7EQ8JJuISY7Xt4Asjz6JxBjxUHT5ZB2p8cGX5Plpg0ZXCg3LO+3PCppp+Aj7
 4yaA==
X-Gm-Message-State: AOJu0Yyem4KzfKFl0C4VHFSXKaDvppchEPRzxML3vgcFv+pAkrHC+8W7
 UjzRDddC/3dNUVtwUj4YTJ3QpzHySOL0Ojpc9wyi7wtBwlBW4Wpn7fhrMN68sCVb96U=
X-Gm-Gg: ASbGncuYzgE41tpzHAKXQgMQ78ZY5ah2unDp0GsAmFdTWO4JbxO1xsZrI/ctsWQx+J9
 ptaNYhG4VAPwqUU8N6yUpiyXY/3XfEe/dPV+DgM88j28ip4lPu1fstcqMsCXRMntnfQ8IkR7wK/
 A4Wsw8SnHhsUMjv6nnP5VzwO7ha7xn9G+La5pKGn4WFauh/OKf0qDRK10qCztaEtCTWCzFmgTfe
 XP3WffAa/tQiPGR8UcFyRWskesr+10F2dB916ZqxinbEmsJF+VAeGXSy0m2M0ANFPVpqkaCUeL8
 WGsjo1XtULZF8aYvGfwjhUFamc5xYSWAJC9C86KStptHvqhgHePgxZp/YFhy7WFv5mr4rfUEpA=
 =
X-Google-Smtp-Source: AGHT+IEW7UfHRVV7hKr54Lu4wdWzV+vFYwQox+EmqzSVp16j86D/AAIb3NiiVIqbbFHvgR8aj/UKmA==
X-Received: by 2002:a05:600c:1d1a:b0:43c:fffc:7886 with SMTP id
 5b1f17b1804b1-4538ee341afmr30891915e9.8.1751023514995; 
 Fri, 27 Jun 2025 04:25:14 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538233c4acsm76309695e9.1.2025.06.27.04.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5E8DE5F886;
 Fri, 27 Jun 2025 12:25:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/15] tests/functional: Add PCI hotplug test for aarch64
Date: Fri, 27 Jun 2025 12:24:58 +0100
Message-ID: <20250627112512.1880708-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
[AJB: trimmed boilerplate to keep checkpatch happy]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS                                  |  6 ++
 tests/functional/meson.build                 |  1 +
 tests/functional/test_aarch64_hotplug_pci.py | 71 ++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100755 tests/functional/test_aarch64_hotplug_pci.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 27f4fe3f25..0a7c7f3770 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2082,6 +2082,12 @@ S: Supported
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
index 0000000000..25e40702b0
--- /dev/null
+++ b/tests/functional/test_aarch64_hotplug_pci.py
@@ -0,0 +1,71 @@
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
2.47.2


