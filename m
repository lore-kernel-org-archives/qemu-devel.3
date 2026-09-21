Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA39C982FA
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrh-0006GB-9J; Mon, 21 Sep 2026 17:47:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lre-0006Fr-CE
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:54 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrc-0000DG-EZ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:53 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49b912e64ccso25345115e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027261; x=1790632061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N+0bT9SGhq4R20EZPcdbMBnR24uL5rFJiJp9EUZDAIs=;
 b=mEQzp95yNu5obau0Z5xmM4SOTqmCM6py6UlJlgjPAuV7vzkATNFaw5kdwbnAIQ7vib
 9L/J3+qm61sztXn+hVZ4PFZp+Kx0ID2XOF7Dy2t8u4w7BQZbF1KGfelxB6gK40h8wNuP
 OTSU/TR6aqoV7aAdKFS5Mp2FN+YQzpGme2ye90dnR5QCxsoDma2NMH7jXfCiOqiKc87U
 VurXKaiQdBeRdkDolLqwQsiaxZtqFU0LohMEWPPz+70QKqnKyaOHBAnKrSqRsxTJ4zMq
 VcUfH9vlIhDCrYOjeuWteTdW6yMKaWdgdjN9D8klXApWiEgXwqpxE/KO2+LaXP7+uXKG
 YGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027261; x=1790632061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=N+0bT9SGhq4R20EZPcdbMBnR24uL5rFJiJp9EUZDAIs=;
 b=uy/SUZVSrQYLsrJzJzbtbLsaQT4FylYru1cEG8rmQU6x2C7u6RIMI04CnrJNCd3qWZ
 Hqp1uvCpZR8UazmfwdFWU1ROdxu6aDgNhk43MpSG17HxMZHA+FPxDV6c8d3eqfd2wZUT
 J+nqvZi45Du5OWng3tB5BSTogOyeD3zkWMfGFeSrFB+bQetG6Wb5GiBg5A/isCzAl4kO
 CaaNoxzKO5hj99Om4VXNE9W2vAN4AlLr59Z4g7xBNhcmT2CIGNmq4Z2BoDM7nAGH3/IH
 CfiSg1qKX2PEf2bGycDKhgsvEL01dH120JCpA9sRY3V4wNE97Y6RpO4rt01yjOfGsGzk
 IowQ==
X-Gm-Message-State: AFuF++nRuGXwJmYFvT4XsbZT6xvu2bEtYkY1XKGtuYgJY0XQomM37fIe
 KQDzdzyJcFSIpeUyLby39ut9UFKuj+FK/U41i6ceZNwIE15s5nFzhXtBRwaigg==
X-Gm-Gg: AYBFou0N75xG6F8KqppOmyzdo2JkYotrmPny565O7k5NliAP/MRIX8Qwtn8RSiv0H+Q
 atw9mqFeHbEzF0tl9Rvj2mGLdq3oM+LbNKuBY8K+dOInIwKtOwPhpibOUUty3210qKl0dgZjuG+
 xSp2pK620L09N7XnNjGnXqiAbUEGKF9hJNIlO1+PnMNC0yzoEFeckPIeuUtl71EVxpGLwtdeCAc
 9qADfxGca6tQaGzHWyfw7Bzuwq2BON+NoCfPR8ryWNCQVG4oBvZFfOpkK42U1LgcmQCIm61pXWD
 Co9IrQ1W61VXVOl7Ip8dsBW/j8qm46a1QXboii4k8bI449wRF2HGQrXWttZnuQ9tL6Y2DCsSBBp
 FimO8P5bzVV4wNuFYtmJF8BRyGkOVLXOSjQJlzV9vzyUFopyT5j1J8RhC/fKEz1UdeMj/9g5rpF
 GuWxISnkCZU+eorxehAU95r9rkOubmXCvyGBSi8iRuZrnFPX5yJCJlPBwMxOvnkO3x7VjHfJHA6
 eusmCT7UUvqY1LkKNzdtj+doljNm9xP4EOcKFjahxOaBZHFzj4HWImcfnH3IiHHjEWdBdLZcMS1
 F5A=
X-Received: by 2002:a05:600c:4e4c:b0:49f:bd3c:bc28 with SMTP id
 5b1f17b1804b1-49fc574f456mr172605295e9.35.1790027260993; 
 Mon, 21 Sep 2026 14:47:40 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:40 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 10/42] tests/functional/arm: Add console test for
 `mcimx7d-sabre` machine
Date: Mon, 21 Sep 2026 23:46:38 +0200
Message-ID: <20260921214710.29422-11-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS                                |  1 +
 tests/functional/arm/meson.build           |  1 +
 tests/functional/arm/test_mcimx7d_sabre.py | 46 ++++++++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100755 tests/functional/arm/test_mcimx7d_sabre.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 7cc9e558f9..866983d8ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -932,6 +932,7 @@ F: include/hw/misc/imx7_*.h
 F: hw/pci-host/designware.c
 F: include/hw/pci-host/designware.h
 F: docs/system/arm/mcimx7d-sabre.rst
+F: tests/functional/arm/test_mcimx7d_sabre.py
 
 MCIMX8MM-EVK / iMX8MM
 M: Gaurav Sharma <gaurav.sharma_7@nxp.com>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 761b371a8d..e49a04ea6a 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -20,6 +20,7 @@ test_arm_timeouts = {
   'bpim2u' : 500,
   'collie' : 180,
   'cubieboard' : 360,
+  'mcimx7d-sabre' : 240,
   'orangepi' : 540,
   'quanta_gsj' : 240,
   'raspi2' : 120,
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
2.55.0


