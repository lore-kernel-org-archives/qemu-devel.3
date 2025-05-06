Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B4DC3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:47:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJY9-0006En-Bj; Tue, 06 May 2025 10:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVM-0001tw-1y
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVJ-00029Z-LW
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:43 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c0dfad22aso3718440f8f.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542560; x=1747147360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=56khE8Uaw81lXGUNJgzYq9SIPvkDB3r1al+lhASF9Ts=;
 b=IpKcNZsOwzMDGNbrSFReIycomj8rLMzLknku1+mPhPpfUtoRCCzCHu6GebUODiU8zQ
 NHMdKEmAjy2JwSDG139FvjjAKtdFn4I05pRs9mgyDSjuMq1Idyq5eBLvGP7KPe96JPqi
 +5LjGIdSVsPx3Q857lO0K/oDahr6XMxpUFMY1VbC/8Hi0QSuL/FRuzp2YRl88ybLcYAt
 uHWAuPGI4ozfXtQmnX7Tozv2V5oxIMaRgpzXGgz6MKDBQj+WrQ98lgfnM+m7cyYc74HZ
 cnnIVZtm0WIJ7LuPnxj68MboyPcDQJfaWFESLtLmYkk/FgyeOhi22SRDhDiiPNEGcX9A
 JSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542560; x=1747147360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=56khE8Uaw81lXGUNJgzYq9SIPvkDB3r1al+lhASF9Ts=;
 b=AI1j3LRA8Z0n1ivSvRCwRzoKqsttuu4f2EbWRBARKMozsua+bOmGCiojfZpkJCvYGj
 4elJls534qr7tNN1/APnk5C4f97aVD2F7kyFEhma4iXTtsdb3veF0u0EYUtgxPeoHdgX
 FSOf3ofT8LYzA4RLHNRKoh8XgDPmT+tn0c7fGDHopOmjWXkKLQ2Wp/XPQJnu6q3MDLzE
 HXwk3T2qo9S/TtKfwuzEt83e4gntO/HWuHhgLdQqlfyatr0eWTXvqWl2CzHKyaLEXYZ3
 kB4eO8z9UkkyKuY5lLlvxpVIZG1i+dQ06dDL7e0Ic1VI3l1CtuK3WXcxxIYsF/9/a1ul
 C5YQ==
X-Gm-Message-State: AOJu0YzFbbSpPMrl6oPifaODLovbnMJlOdVav7a6cn15SB18B0B1Y1ns
 2TDVLWC3xJkMRxbyC4hiBaZ7frzCE/4Wb+yc1o2GYSZsXlvCQyChbha6lMdYU38sMKMU7W+IEYo
 X
X-Gm-Gg: ASbGncs4kY/cb8Dma9IVCV4zDlKVczZ047qmR63U+APAjyCi3z6BwEwAJFe2mEZhTaF
 dXdP47Y2/jNT4VHxWkQ5pVA1pv7l6haOgFhsxMRypDwv4rlI2yU8NQJrI54s/KofAhaVvLwlCcN
 i+9bALe3lnQzVoc4kibbYxG0RjpbJ6A4Hsetx8x6CFuPRDEp8K4j7tYt0SJXV1t5ffXN2VQUEph
 F/WkRxlGFTNwkzyINd9clYH35BZ1tg0dmyohZINo3GQgGgTFz9gxUC1FwAmzuNQVDGtemOVENJQ
 gTG0faCgrC+deW2Oe+zH5O6i9amz3pK7D4g+8yvVDuTRFeY=
X-Google-Smtp-Source: AGHT+IGTUta68M4EfwFGQCal/dEDsNODrpxR5FWYiqbBOe9n+oGxKq2PJJRHvEK54zafPmiPV9Xwbg==
X-Received: by 2002:adf:e30c:0:b0:3a0:9fe1:c298 with SMTP id
 ffacd0b85a97d-3a09fe1c4aamr6459335f8f.18.1746542560059; 
 Tue, 06 May 2025 07:42:40 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/32] tests/functional: Add test for imx8mp-evk board with
 USDHC coverage
Date: Tue,  6 May 2025 15:42:03 +0100
Message-ID: <20250506144214.1221450-22-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Introduce a functional test which boots Debian 12 on the imx8mp-evk board. Since
the root filesystem resides on an SD card, the test also verifies the basic
operation of the USDHC.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20250409202630.19667-1-shentey@gmail.com
[PMM: added extra blank line as suggested by thuth;
 set timeout to 240s]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                                 |  1 +
 tests/functional/meson.build                |  2 +
 tests/functional/test_aarch64_imx8mp_evk.py | 67 +++++++++++++++++++++
 3 files changed, 70 insertions(+)
 create mode 100755 tests/functional/test_aarch64_imx8mp_evk.py

diff --git a/MAINTAINERS b/MAINTAINERS
index e748b6375ee..ba702549466 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -843,6 +843,7 @@ F: include/hw/arm/fsl-imx8mp.h
 F: include/hw/misc/imx8mp_*.h
 F: include/hw/pci-host/fsl_imx8m_phy.h
 F: docs/system/arm/imx8mp-evk.rst
+F: tests/functional/test_aarch64_imx8mp_evk.py
 F: tests/qtest/rs5c372-test.c
 
 MPS2 / MPS3
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index ab9df03b1f6..52b4706cfe8 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -13,6 +13,7 @@ endif
 test_timeouts = {
   'aarch64_aspeed_ast2700' : 600,
   'aarch64_aspeed_ast2700fc' : 600,
+  'aarch64_imx8mp_evk' : 240,
   'aarch64_raspi4' : 480,
   'aarch64_reverse_debug' : 180,
   'aarch64_rme_virt' : 1200,
@@ -82,6 +83,7 @@ tests_aarch64_system_quick = [
 tests_aarch64_system_thorough = [
   'aarch64_aspeed_ast2700',
   'aarch64_aspeed_ast2700fc',
+  'aarch64_imx8mp_evk',
   'aarch64_raspi3',
   'aarch64_raspi4',
   'aarch64_replay',
diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/test_aarch64_imx8mp_evk.py
new file mode 100755
index 00000000000..638bf9e1310
--- /dev/null
+++ b/tests/functional/test_aarch64_imx8mp_evk.py
@@ -0,0 +1,67 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+
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
+        self.image_path = self.scratch_file("disk.raw")
+        self.kernel_path = self.scratch_file("linux")
+        self.initrd_path = self.scratch_file("initrd.zstd")
+        self.dtb_path = self.scratch_file("imx8mp-evk.dtb")
+
+        self.archive_extract(self.ASSET_IMAGE)
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
+                         '-kernel', self.kernel_path,
+                         '-initrd', self.initrd_path,
+                         '-dtb', self.dtb_path,
+                         '-append', 'root=/dev/mmcblk2p1',
+                         '-drive', f'file={self.image_path},if=sd,bus=2,'
+                                    'format=raw,id=mmcblk2,snapshot=on')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('Welcome to ')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.43.0


