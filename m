Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F8EC36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 20:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2c0T-0006Hp-Kn; Wed, 09 Apr 2025 16:26:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u2c0R-0006HY-L5; Wed, 09 Apr 2025 16:26:43 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1u2c0P-0000vi-Qp; Wed, 09 Apr 2025 16:26:43 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5e5e1a38c1aso118853a12.2; 
 Wed, 09 Apr 2025 13:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744230399; x=1744835199; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rrt7jL8lifFq0pPIvqMAcPOa40ZyUaxWAyL/gY6pVoQ=;
 b=TMK/znCP2VP8tN5o2oixQqxXZDRT5rtOUJmKoyDZV/ZLSBdj7MIr5XXGWSe0HY0taG
 t0x85gX/KYlGgtDsYPucH3TGPJIN2GLNxhZVZmcRri7L0E2hRuUHYoepeOVmGNGYRNaj
 5mXpZfpm/QsYENNOVxMuXymDX/bzJO+K6uV8A8UkSMy4YSyduqhOlLXttBy0b82LLaEd
 icbWUY8dJFXqc8UCpMrYesVddSo9IcBZYJj+Puox7oi24C6M8mkrxjORSa7ULxzAJGxL
 5Np+jw5n9yxMdmyIgYGXVQQ68JhDSaVAABKBUOrmMRFXY7pryS+UYZa0Zdm432hSr8QV
 dS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744230399; x=1744835199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rrt7jL8lifFq0pPIvqMAcPOa40ZyUaxWAyL/gY6pVoQ=;
 b=H9320k73yaFNPYyUzjpd10KvAgqy3llHTCtlFsIl8RPECMLi56w6LTX0VxcJWlf2GU
 Xub2ojJYKHaIyARwhCrfK/X1eLLLKIw0DY1q+s0vYn5Y+RahnseRdN9ghMWDmoaki+Dw
 NkmfDz53MyD+m4RGmH1Uw5ZfnvhK5WD4Bc/nWloKniiI+ba5mIg/63FmpjXY+byuMPvX
 R02FS6HIAU/xcGmqDLtnMC5VGceKGQSDXCIX1PGDaZ5v8B8HO0TFsyp+lOoIDPCUEkz9
 UzZI+d20xtfmOz1pFb7SaTHE5dMjylbZG8H2T121vNZKm1DUE+AlBNL7Tm96yH3WiLi8
 l8ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFkGq2gPeFbHvVLmLnAdDBlju4hidYIJl0eoIm32nnzXJniqcvruuBO58xEz6/4EHwhBXJ1KfRtg==@nongnu.org
X-Gm-Message-State: AOJu0YyDtZYfpRpCa0jdacmsJmGfom8tmGbaj4bgwjDWPbd/9R6bNybN
 +lN+6I+8tL4MBp5buE2AepDEoH4GrY8WsQ+u64XRsYZFEfxebV1K4SKhGA==
X-Gm-Gg: ASbGnctebyfNTnlAFm7p2NISsDBl4AMIBfjEcqjJu+w+1OqlWDADcIXpZFb9hH8WqBm
 27pF8AaVTssGEbBULtmR90+QYm0UYG/vm1hit7GvzT9GBrxdLHViX4553QHEuI+r3tAH7QXnvOh
 omju8+rzHuD5Nk7wGQ5DqSLpDlflfaEd0i2DAKxXYoNw+hYumSgb+6XU/dEPWHTHo0IqK8Fjq0J
 yNn/JiM569BT15YDnxjsnYIedNVbNF+LdGjJ4lC9huAz4Bvtj0DKCayvCWlAx+3kZDoT+Dj2TnZ
 aIdUowIks36FAmfRFtkgmmdmxiR0LbTFhLf8v8+M2/MMA3PYUY0FRELT2vs1V7u1lWZV+PZXdhs
 gSmTuEl/8J9UOFs/4mUqIYxG9Ch9qk/KF/5NZ41ebHS1FdBf+HNCvTmgTJfn6
X-Google-Smtp-Source: AGHT+IFldrzC1vDsYyXdE7JhiFSBejuKNrsyLx2BOTG4rJltF9rab8wWfLUgNV2jysgMfyAKGPVB4Q==
X-Received: by 2002:a05:6402:90b:b0:5f3:2665:f961 with SMTP id
 4fb4d7f45d1cf-5f32932dadamr133807a12.33.1744230398550; 
 Wed, 09 Apr 2025 13:26:38 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-242e-7100-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:242e:7100:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f2fbc2e3f8sm1259373a12.48.2025.04.09.13.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 13:26:38 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH-for-10.0? v2] tests/functional: Add test for imx8mp-evk board
 with USDHC coverage
Date: Wed,  9 Apr 2025 22:26:30 +0200
Message-ID: <20250409202630.19667-1-shentey@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FREEMAIL_REPLY=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--
v2:
* Make test file executable (Thomas)
* Omit fetch() (Thomas)
* Omit "-accel tcg" (Thomas)
* Add "snapshot=on" to make potential future tests independent

Supersedes: 20250405214900.7114-1-shentey@gmail.com
---
 MAINTAINERS                                 |  1 +
 tests/functional/meson.build                |  1 +
 tests/functional/test_aarch64_imx8mp_evk.py | 66 +++++++++++++++++++++
 3 files changed, 68 insertions(+)
 create mode 100755 tests/functional/test_aarch64_imx8mp_evk.py

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
new file mode 100755
index 0000000000..62fee74044
--- /dev/null
+++ b/tests/functional/test_aarch64_imx8mp_evk.py
@@ -0,0 +1,66 @@
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
2.49.0


