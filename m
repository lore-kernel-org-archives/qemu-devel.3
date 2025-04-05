Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6ECC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 21:50:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1BOO-0003Sy-Hn; Sat, 05 Apr 2025 17:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u1BOC-0003R7-Es; Sat, 05 Apr 2025 17:49:25 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u1BO8-0004NB-GV; Sat, 05 Apr 2025 17:49:19 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5e5b6f3025dso4766147a12.1; 
 Sat, 05 Apr 2025 14:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743889752; x=1744494552; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u76IOBSMbjJcH5OQHSSw28t6GnCDxPKsnRcq6i4Xx/A=;
 b=Va8/37DxH+s5dhtbewbbEP8p2uvBLwrgPQ8GcwvDYwgnPFr0A6fgsc5ox+sjelxxey
 WmgwlEgFOGHZXUIr/mjZKQKTbFhg+e7liIgv8e76xG3aDYMqmbdauq7cwDscKGBAR5cA
 v1nitOizc9jJDz080sN5EpqK3Md6MEFJh29VokH7GZFxs6H4c2YIHUYAYe7TpyFt6XlX
 xDfoV7ZxVz7krUMd3OXctcHX/IBUmxU6Ze9sB1ZuJM32xm+QuNanPMGXyYP/IsRgijRa
 0J/IAHal1ENz81lJifo2uSDj7bXF46jto3qOnNyb6NZa7wp44cKl0T/ZkYFv7RrbLs7w
 I4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743889752; x=1744494552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u76IOBSMbjJcH5OQHSSw28t6GnCDxPKsnRcq6i4Xx/A=;
 b=Xsf8Peu6ziag99SlYZb8wYhDwePUKpwLz33HrBePUz2cHNJTtD2Vs/ByaJKHc3sJZR
 zZ7aQW6POr4Pe9LKaJ5WPRoJNRVhar2gwOPHdAw/br1ul8iVl4vvNq3B0ureRpA0uF6d
 10qSMo1xQ9dW0VqxH4OBYdb4XcxjSlWNge1miIr2XoTnrmzH1n8x6SoB2w8Jvw8wp/qg
 zs4HXvDTU6qCFg6O8Pw6NcID4MW7iARH/P2TQcXfZaqZMbMXXZOQ5GESloTpMDQXXByd
 slKi/4KSkH3hpDXR65AxGBbajB+ZpkUKo7emOsfw9MAtGfaWRQi4rFFEcCtI/w7JUaax
 sd1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4OGzvhtPbcf3IFZ2oVTSBtNju/Xmw21R3jKuNdG5uiJu0leVQ+T5BZLAom78OGIy1XvbogzkC/A==@nongnu.org
X-Gm-Message-State: AOJu0Yx9Bx8zJ6ati0cfSCfIbyZYCQj/d1A9h0go9OlHcDtJNBmPTPFi
 dUxXpxJOcR9wq6Fn24e22Qbaurb3x/HtWXevCLzikbpkpWq7ZcieizpMHw==
X-Gm-Gg: ASbGncvS/zZy8/A4c4utQncGCi0ijS2qUymNy99K3K07Bp6ze7BM4qyP8TW4yydb9A6
 VDT2fbXhVEZEsgkToGVruB7sAWr7rK2EkSlUogth0lOkC6ncTzlwgK5EAmSdZA551tK9Q+5W5Uu
 DaOVfPhZz6ViWYmA4w/HNbV0sX7ZL7neQwshH/QNPdNhSNDMDBpZ2uROMct/ma07JMppLX+EAvr
 /v30M39ZuTVSmSYkcW2rmEQSE9PpkCY0tbnSG0bKZ886pczmD6yIQvI0Awl3zuyiufRhmvfiW7u
 kkuQabYfoGxkSRA9KVxjcPhCaitn6V3TCpPgeJXnGZBIrumG6bFabiMaoaJXy1bQfxRL3IHIyfK
 d5npCvLOztBxJWmVS3xfabrhyyarIFUeK4VQ9qwP4IUVrrfEc0/02dkr2Slw0jf/s
X-Google-Smtp-Source: AGHT+IHClfgrrzP+qDv/6NwNgOcws0UaUkMiUJXhZylZWUX1qDh7wU6J8H4Feio1CxGzX1cDKuIlyQ==
X-Received: by 2002:a05:6402:13d5:b0:5ed:191c:ed23 with SMTP id
 4fb4d7f45d1cf-5f0db7fe763mr3633653a12.3.1743889751541; 
 Sat, 05 Apr 2025 14:49:11 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-1bf0-7700-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1bf0:7700:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f0880a535fsm4382270a12.80.2025.04.05.14.49.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Apr 2025 14:49:11 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-10.0 1/3] tests/functional: Add test for imx8mp-evk board
 with USDHC coverage
Date: Sat,  5 Apr 2025 23:48:58 +0200
Message-ID: <20250405214900.7114-2-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250405214900.7114-1-shentey@gmail.com>
References: <20250405214900.7114-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Introduce a functional test which boots Debian 12 on the imx8mp-evk board. Since
the root filesystem resides on an SD card, the test also verifies the basic
operation of the USDHC.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                                 |  1 +
 tests/functional/meson.build                |  1 +
 tests/functional/test_aarch64_imx8mp_evk.py | 69 +++++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 tests/functional/test_aarch64_imx8mp_evk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index d54b5578f8..4ceffa89dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -833,6 +833,7 @@ F: include/hw/arm/fsl-imx8mp.h
 F: include/hw/misc/imx8mp_*.h
 F: include/hw/pci-host/fsl_imx8m_phy.h
 F: docs/system/arm/imx8mp-evk.rst
+F: tests/functional/test_aarch64_imx8mp_evk.py
 F: tests/qtest/rs5c372-test.c
 
 MPS2 / MPS3
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 0f8be30fe2..aaaf3472f1 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -75,6 +75,7 @@ tests_aarch64_system_quick = [
 
 tests_aarch64_system_thorough = [
   'aarch64_aspeed',
+  'aarch64_imx8mp_evk',
   'aarch64_raspi3',
   'aarch64_raspi4',
   'aarch64_replay',
diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/test_aarch64_imx8mp_evk.py
new file mode 100644
index 0000000000..5419d3c525
--- /dev/null
+++ b/tests/functional/test_aarch64_imx8mp_evk.py
@@ -0,0 +1,69 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
+class Imx8mpEvkMachine(LinuxKernelTest):
+
+    ASSET_IMAGE = Asset(
+        ('https://cloud.debian.org/images/cloud/bookworm/20231210-1590/'
+         'debian-12-generic-arm64-20231210-1590.tar.xz'),
+        '7ebf1577b32d5af6204df74b54ca2e4675de9b5a9fa14f3ff70b88eeb7b3b359')
+
+    KERNEL_OFFSET = 0x51000000
+    KERNEL_SIZE = 32622528
+    INITRD_OFFSET = 0x76000000
+    INITRD_SIZE = 30987766
+    DTB_OFFSET = 0x64F51000
+    DTB_SIZE = 45 * 1024
+
+    def extract(self, in_path, out_path, offset, size):
+        try:
+            with open(in_path, "rb") as source:
+                source.seek(offset)
+                data = source.read(size)
+            with open(out_path, "wb") as target:
+                target.write(data)
+        except (IOError, ValueError) as e:
+            self.log.error(f"Failed to extract {out_path}: {e}")
+            raise
+
+    def setUp(self):
+        super().setUp()
+
+        self.ASSET_IMAGE.fetch()
+        self.archive_extract(self.ASSET_IMAGE)
+
+        self.image_path = self.scratch_file("disk.raw")
+        self.kernel_path = self.scratch_file("linux")
+        self.initrd_path = self.scratch_file("initrd.zstd")
+        self.dtb_path = self.scratch_file("imx8mp-evk.dtb")
+
+        self.extract(self.image_path, self.kernel_path,
+                     self.KERNEL_OFFSET, self.KERNEL_SIZE)
+        self.extract(self.image_path, self.initrd_path,
+                     self.INITRD_OFFSET, self.INITRD_SIZE)
+        self.extract(self.image_path, self.dtb_path,
+                     self.DTB_OFFSET, self.DTB_SIZE)
+
+    def test_aarch64_imx8mp_evk_usdhc(self):
+        self.set_machine('imx8mp-evk')
+        self.vm.set_console(console_index=1)
+        self.vm.add_args('-m', '2G',
+                         '-smp', '4',
+                         '-accel', 'tcg',
+                         '-kernel', self.kernel_path,
+                         '-initrd', self.initrd_path,
+                         '-dtb', self.dtb_path,
+                         '-append', 'root=/dev/mmcblk2p1',
+                         '-drive', f'file={self.image_path},if=sd,bus=2,'
+                                    'format=raw,id=mmcblk2')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Welcome to ')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.49.0


