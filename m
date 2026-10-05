Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27273CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfq2-00072L-8F; Mon, 05 Oct 2026 06:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmL-0002HL-TM
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmJ-0000xB-OL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:41 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48b0d19cf7eso565651f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195518; x=1791800318; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pOxduKRCTuytQO5PRMLsrv51EvLlQX2lLk9OuLBZpag=;
 b=K5gA4kWEChze9H2VWgPBuxzjI01h6Kju2mO9o5reoTTiinP1sSmagaovyLD5cJNnhM
 mG5uENVKIRlwoqpC6juGypC3MO/dmmB8cSbsb2IZy8L8nDBaHZBmMx9GoFjvR/j9+pb0
 SLROUHAGuvm4z5EBdR5L5yr69QuvsusfGEWwxXxIzL2EIk4g64DIMtOLXo9MjbvreVZ1
 Vhcc5AlVX8h7gldciRMS2RdnNSdccYGgrkPX+e5fmx3fKPSexWKHvftwnDgx7RgAq4Fp
 tbXzHV/QAtcXMGbrdQxk0/1ntz5zl1XBUzP9a3My9m9rQMoETNcph4+JrzTLv/lCEsFn
 TCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195518; x=1791800318;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pOxduKRCTuytQO5PRMLsrv51EvLlQX2lLk9OuLBZpag=;
 b=HXB3iJn9NOuk/uygDmz79O3cFGNvnuULrHbyMLu516ErQsts4rIq+d0VaeJDt/67LI
 UImMvXdyUz1nz4Fzyak72LbWLUZ6qkGeDgYhIbMzAJw1cvgrUnfTQbBZe/vEkQgq5zbA
 +6RbIJ/dJ7PCvRXbRT2oaM44+Sva/TswOcIAoZ1NateTdnh02+jF4sfOeSvcCbxK5Elx
 9aIYT3H+JFD3a23TGYR0QOIIoYrKi3WB3DZGfgg/y5hmtWX4dIaldk5pp6VzQGs7z56j
 FdLFRyVBOEyS2HCi2FbBQsM8j0MtXHLpvCihUdgKDx9eQUKcMbUm1HXmqWyLLQlQLm65
 JSIw==
X-Gm-Message-State: AFq9FYJrIrF0lWxiNkMyknsDcjNgt5WbJ/0hFaZ1fp/+3lEy+ipkXRfw
 4MjH7blwgq6TZsLIMvCOgKCPh/iPfDj5v6c+9loVGZzJNCsqUfebH3hkuZXpXg==
X-Gm-Gg: AYBFou29n8mFHxni9j76biQrRW6Aia/MDrkQyaa1VNqQ8vJ0d71bjk5QLxbRQLOB3be
 NPbe9gjvYqOZ4r5OfmQ/t79W2cnPoEnMCvWkyp0YyLZl4RI638RS7jXU8dd+N+a1Elk+ZG/9W4K
 zjW1zGSBeiQatQlYy5yV6C3+D+0+7hoTUnCl6cBP4Lm+WfhUVqv6mpAAGqi+YPJgytHgBFs/hmz
 baUoWuUzficyaCDB4Q3CaaxH6MXpXj3jLLrCWCuSwYvhfWgKS5tUo/7Ua0P4imCOGYdNemizJSV
 Mju6pvqxl5I2aUPZ4EP/ATpIaS9CLvQhfIF/FRQrPH7WZf4IxIEPlZFNAUwU7HKPs1yrgk1Mw+e
 f3yD1W3eeiNp9NckSE2iKtOFpKBjIA3OlhF2iEcKVi/IVDMu8Xm1Sss9qPcFsY3cg3VFNSahBtI
 RcMSbslA1RurM7sGZWkAHRa2rvY2zF1yFPFfApOZtE3TBCXd1lPdA59djn0h84HVGvQ5gR7H4hI
 zndZ9TmlDzy5raSdQ6XKzXasSNUbkQeOx/jIQ==
X-Received: by 2002:a5d:4609:0:b0:48a:fff3:f9c1 with SMTP id
 ffacd0b85a97d-48b067c2795mr16655720f8f.20.1791195518082; 
 Mon, 05 Oct 2026 03:18:38 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:37 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 11/31] tests/functional/arm: Add console test for
 `mcimx7d-sabre` machine
Date: Mon,  5 Oct 2026 12:17:38 +0200
Message-ID: <20261005101800.10821-12-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x430.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The test currently exercises the Linux kernel and waits for the first
daemons to be started. At this point, basic hardware is initialized and
if the log message is reached, no driver ended up in an endless loop,
thus the system should be usable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                                |  1 +
 tests/functional/arm/meson.build           |  2 +
 tests/functional/arm/test_mcimx7d_sabre.py | 46 ++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py

diff --git a/MAINTAINERS b/MAINTAINERS
index f31245716a..a605d65d94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -935,6 +935,7 @@ F: include/hw/misc/imx7_*.h
 F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
 F: docs/system/arm/mcimx7d-sabre.rst
+F: tests/functional/arm/test_mcimx7d_sabre.py
 
 MCIMX8MM-EVK / iMX8MM
 M: Gaurav Sharma <gaurav.sharma_7@nxp.com>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 989b841555..e657ecd278 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -20,6 +20,7 @@ test_arm_timeouts = {
   'bpim2u' : 500,
   'collie' : 180,
   'cubieboard' : 360,
+  'mcimx7d_sabre' : 240,
   'orangepi' : 540,
   'quanta_gsj' : 240,
   'raspi2' : 120,
@@ -60,6 +61,7 @@ tests_arm_system_thorough = [
   'emcraft_sf2',
   'integratorcp',
   'max78000fthr',
+  'mcimx7d_sabre',
   'microbit',
   'orangepi',
   'quanta_gsj',
diff --git a/tests/functional/arm/test_mcimx7d_sabre.py b/tests/functional/arm/test_mcimx7d_sabre.py
new file mode 100755
index 0000000000..2894b5201f
--- /dev/null
+++ b/tests/functional/arm/test_mcimx7d_sabre.py
@@ -0,0 +1,46 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
+
+class Mcimx7dSabreMachine(LinuxKernelTest):
+
+    ASSET_KERNEL = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/netboot/vmlinuz'),
+        '5851e9c61465a26db810796db671c4729e66e81c365b3ebb1a4b7f772737605b')
+
+    ASSET_INITRD = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/netboot/initrd.gz'),
+        'fe33f836232a9107716d34dc56d36dea81bab039243a2a42ea6583a50c9b92ca')
+
+    ASSET_DTB = Asset(
+        ('https://ftp.debian.org/debian/dists/bookworm/main/installer-armhf/'
+         '20230607/images/device-tree/imx7d-sdb.dtb'),
+        'eed45fe3ba682cc814217bc4558551d36c034ec7a7692c4eb6eaf86132baf80c')
+
+    def setUp(self):
+        super().setUp()
+
+        self.kernel_path = self.ASSET_KERNEL.fetch()
+        self.initrd_path = self.ASSET_INITRD.fetch()
+        self.dtb_path = self.ASSET_DTB.fetch()
+
+    def test_console(self):
+        self.require_accelerator("tcg")
+        self.set_machine('mcimx7d-sabre')
+        self.vm.set_console(console_index=0)
+        self.vm.add_args('-kernel', self.kernel_path,
+                         '-initrd', self.initrd_path,
+                         '-dtb', self.dtb_path)
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Starting system log daemon:')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.56.0


