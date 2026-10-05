Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E69ECA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfou-0004BE-UA; Mon, 05 Oct 2026 06:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmL-0002HJ-Qc
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:45 -0400
Received: from mail-wr2-x0e.google.com ([2a00:1450:4864:30::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmI-0000wY-HC
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:41 -0400
Received: by mail-wr2-x0e.google.com with SMTP id
 ffacd0b85a97d-48b01c4f4daso1274836f8f.1
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195514; x=1791800314; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bqD+aHtTbFAXv8DMY6Gl5FICoqplgP4XudJ8kGw3u/c=;
 b=f/581tBnwyKQfi0xzYILC2osCNafVeJJTO8MDjslDKED3uT/SxhBleQ8BZVtH0P/Fr
 oZMfAk9wJ4vh5DKNNTQNBIFrtf3BovpSElIjtUBJXIkOA0h2UJcJSLDAsf6dttOi8WQC
 YjLPfpt+lJ5LwWFs5Nibs8evIcF1lRKxCLua9a4QCYufUiPgSmiCXJF2mDI6rX+220SO
 j77nmEzZY4nwo09w8mjh9pCkDRbZCzDVPM3MGg7ehOv200+/4Ma07lCL20icKprjYK3f
 XXIsW8JtayFhl/aggWuFQVs+TE94qDh9Hh671Ni9RAuE77PN8Ou/2NFNPh8E5iRLXJZ5
 u0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195514; x=1791800314;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bqD+aHtTbFAXv8DMY6Gl5FICoqplgP4XudJ8kGw3u/c=;
 b=jlguXwPfQBWQreaZ/i1WuJBxK7wEiqoIn+yZ6K6jP3Do1HksPeWWLXbwLWJVmZUsJE
 JPCTIEGQiKeWbyQ5peZei8xtDTcrTeNiCHUqa9S3tdVdiwfyTa0G/eg5Z18V+3zFLcAv
 TqlQ1Hpk8JR9sx6ZRJeUJaaHCK/VP30lpRXoLS2txE8GKmkx1Kn7uAuNGWhGOE2dcUaf
 4JMzqbRYaSLXZv/CdNEQQvkUDdJkeMLsZW1x7SY+cXXdl52Ny86grj6Cd6LYnN6p2Mq4
 j4Qhvx38b24a/EiQnayWjXs3HswUFBfbtyN9wKUYgK9gYbIoulPuiw2vDvSRAInH1mzi
 lccA==
X-Gm-Message-State: AFq9FYLmprHulk3sJE4Wfcy88FJwljZ2nA8OYBDWIdZQWWVcFQgORt+E
 guoRhD1WWYkdnH6ZZWfQXGeYxhX+S0nT9SWYSBVY52V7iwqyY3GkgMuNqL1F/w==
X-Gm-Gg: AYBFou2Us7onR2rfHvnF4jle0YSDFXA8YpwMAwDBhxGIUTLdeCrZm8SV0VS6xo5YpHT
 AErfzZwYRhKYFpgsHVq3PoMCRK6UMaddB1d35AgRu27bm/0+ZN4ujlSBoEawk8Q1Ro9gmiR5dt+
 ahV02JPDNla6lcccX97cwqKGuSVsuMrBWE5hZxu1qHPqcdvCJSoiyTLRlK2XfwNn8h9c9V2BQbz
 Zvok3jOXfMqAKN9xP+WoT8ncleV3MOk0nEGAnnMOJCNh7f0rsBB2UwsmCZCIOr5+FWt7noCM6HO
 jAi275u9O2QRVlWAEJnr06HYbLSSV+2QL98srnxVsLKAXoaLmiwJN1tdHqeTY7zV8XA7TrhqfpR
 lSmsaaV+ir7M4kN3KwHNFyhlBhRAsQ9o3gLTxKxgsDNjuPgFtvdso4FJ3C3zUttspg/Dyi4pLUj
 5t/IOhH8v1yTmm8OB2Hg0FP1WJjfsXTBU6eV8Wt2VEIPywwOxiM7oVoHriAcXuMULfbz5R23Sk3
 lvu3gVCx8yiBOswzc56MIAn4y3EqYsevY7gFw==
X-Received: by 2002:a5d:6d08:0:b0:48b:6d3:a6f with SMTP id
 ffacd0b85a97d-48b1273e314mr13393379f8f.44.1791195514153; 
 Mon, 05 Oct 2026 03:18:34 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:33 -0700 (PDT)
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
Subject: [PATCH v3 08/31] tests/functional/arm: Add console test for
 `sabrelite` machine
Date: Mon,  5 Oct 2026 12:17:35 +0200
Message-ID: <20261005101800.10821-9-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::e;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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
 MAINTAINERS                            |  1 +
 tests/functional/arm/meson.build       |  2 ++
 tests/functional/arm/test_sabrelite.py | 46 ++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100755 tests/functional/arm/test_sabrelite.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 1312bbd1bd..f31245716a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1054,6 +1054,7 @@ F: include/hw/usb/imx-usb-phy.h
 F: include/hw/arm/fsl-imx6.h
 F: include/hw/misc/imx6_*.h
 F: include/hw/ssi/imx_spi.h
+F: tests/functional/arm/test_sabrelite.py
 
 SBSA-REF
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
index 61b00932db..989b841555 100644
--- a/tests/functional/arm/meson.build
+++ b/tests/functional/arm/meson.build
@@ -24,6 +24,7 @@ test_arm_timeouts = {
   'quanta_gsj' : 240,
   'raspi2' : 120,
   'replay' : 240,
+  'sabrelite' : 240,
   'tuxrun' : 240,
   'sx1' : 360,
 }
@@ -65,6 +66,7 @@ tests_arm_system_thorough = [
   'raspi2',
   'realview',
   'replay',
+  'sabrelite',
   'smdkc210',
   'stellaris',
   'sx1',
diff --git a/tests/functional/arm/test_sabrelite.py b/tests/functional/arm/test_sabrelite.py
new file mode 100755
index 0000000000..31a0a49eac
--- /dev/null
+++ b/tests/functional/arm/test_sabrelite.py
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
+class SabreliteMachine(LinuxKernelTest):
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
+         '20230607/images/device-tree/imx6q-sabrelite.dtb'),
+        '3ad637c8ea55ebd058a67f686e050b82ccb0d1327bc283623c133c48ad87db44')
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
+        self.set_machine('sabrelite')
+        self.vm.set_console(console_index=1)
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


