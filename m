Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1800DD3A66C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nv3-0005Lp-KR; Tue, 29 Oct 2024 11:14:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns9-0000oD-Dy
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:07 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nrz-0007gd-Jz
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:05 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-539f84907caso6028076e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214654; x=1730819454; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JhCeGWwX+tCxadLKUoZwKSNi6auX4Bcb310fZRJpZwY=;
 b=nvg4SirYKVtBrZr2NEhqjm1qRD05b5tzunOTEDNN7wKHoXkhA276b68sd120ltCpCY
 t4cCrY576zyMQqMQ+hslPQyIJpuRhMcdvLEe8OmiVIfBZ/MDUC7cH32yJnV5U58BJVfY
 +tN+Xo+PWfQYVxBa3hVbFOWSDU9Rgo5MaBxf9EmYuBlFW6bevvPGzyOFG9eC/pOXxhyG
 Mgj7RR+2ylloef2jsH5raTgrSREL9iR2wLWT/+Sv5Ql2blqOt+V4VpS2lk+qFp/j3MBJ
 M6NwqkvzeSkHJOjHBEr+ACZC3cBY5hgeSdnZmrAe6w0hGMfS+zehWOxXc14UxsYSLkti
 XO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214654; x=1730819454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JhCeGWwX+tCxadLKUoZwKSNi6auX4Bcb310fZRJpZwY=;
 b=viSveYRzwJwmMJI9eu0o5k7sI436xAf1mTz3nMo2/UIXE/grlzVy1lP0pAeSnhqIGm
 +pq6NG1lcmx9WzsvOu6k/YAsO6sfwiglLVVEos/dmstjEo0BTcBMr0h8+psWGqMWhbX7
 zLJ+KxwxbT0FIg0kpBJL7oh7zx0kkW//NFgKZOSCh4uwHTWQKuckol0B4z09L4+wV1qA
 gdCbE+b+rPiUSs9ATRI7E/N3TVXWEf1UQgr3Gd8FrNUoPI5GRdTu0HOqlxc2F3g06gAt
 LgC8oGO1NlQAnzQdxQhEAIF4RQ7Wup+gzX5A6bNrv88BpleDaN5LQ38e33eCG+KdFoe+
 PX4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9wXt1cJ6jMomO+G/CY75qfvjf9+EEOwsx9M6pFP+YnTwT49g+ufiIeE5Uc+kiC7O36yYKKR7CQEic@nongnu.org
X-Gm-Message-State: AOJu0YxMJjrBG6PHtJxGWuthg43YFZUpHPn9VWecLYuNtqHcVzsiQdId
 mu6KhFt9CeS2I4QYrqv46fyoab3jqqTJeJUATLXn20pVUAok1P8N2qHkfZs72X8MePvBAhKmzPP
 8
X-Google-Smtp-Source: AGHT+IFk1CR/zSgpv7hKTo+4OGVx6uDRuIIHA6PRaLxfcRkcnLwbV6FowNoU5G9hK5vboDagERTQKA==
X-Received: by 2002:a05:6512:3ca7:b0:539:e873:6e2 with SMTP id
 2adb3069b0e04-53b348ec22cmr5019179e87.8.1730214653629; 
 Tue, 29 Oct 2024 08:10:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:53 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 07/18] tests/functional: Add a functional test for the sx1 board
Date: Tue, 29 Oct 2024 15:10:37 +0000
Message-Id: <20241029151048.1047247-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12d.google.com
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

Add a functional test for the sx1 board that uses the kernel and
rootfs provided by Guenter Roeck in the linux-test-downloads repo:
 https://github.com/groeck/linux-test-downloads/

We have three variants of the test for this board:
  * just boot initrd
  * boot with filesystem on SD card
  * boot from flash

In all cases these images have a userspace that is configured to
immediately reboot the system on successful boot, and the board
itself supports telling QEMU to do the reboot, so we only need to
wait for QEMU to exit (via -no-reboot).

Since there are three subtests, the test as a whole takes about
80s on my local machine. That's about the same as the aarch64_virt
test, so give it the same overall test timeout as that one.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20241017163247.711244-3-peter.maydell@linaro.org
---
 tests/functional/meson.build     |  2 +
 tests/functional/test_arm_sx1.py | 72 ++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)
 create mode 100755 tests/functional/test_arm_sx1.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 9538e103d6e..84a07970d41 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -18,6 +18,7 @@ test_timeouts = {
   'arm_aspeed' : 600,
   'arm_raspi2' : 120,
   'arm_tuxrun' : 120,
+  'arm_sx1' : 360,
   'mips_malta' : 120,
   'netdev_ethtool' : 180,
   'ppc_40p' : 240,
@@ -57,6 +58,7 @@ tests_arm_system_thorough = [
   'arm_collie',
   'arm_integratorcp',
   'arm_raspi2',
+  'arm_sx1',
   'arm_vexpress',
   'arm_tuxrun',
 ]
diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
new file mode 100755
index 00000000000..2d86405831e
--- /dev/null
+++ b/tests/functional/test_arm_sx1.py
@@ -0,0 +1,72 @@
+#!/usr/bin/env python3
+#
+# Copyright (c) 2024 Linaro Ltd.
+#
+# Functional test that boots a Linux kernel on an sx1 machine
+# and checks the console. We have three variants:
+#  * just boot initrd
+#  * boot with filesystem on SD card
+#  * boot from flash
+# In all cases these images have a userspace that is configured
+# to immediately reboot the system on successful boot, so we
+# only need to wait for QEMU to exit (via -no-reboot).
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class SX1Test(LinuxKernelTest):
+
+    ASSET_ZIMAGE = Asset(
+        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/zImage',
+        'a0271899a8dc2165f9e0adb2d0a57fc839ae3a469722ffc56c77e108a8887615')
+
+    ASSET_INITRD = Asset(
+        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/rootfs-armv4.cpio',
+        '35b0721249821aa544cd85b85d3cb8901db4c6d128eed86ab261e5d9e37d58f8')
+
+    ASSET_SD_FS = Asset(
+        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/rootfs-armv4.ext2',
+        'c1db7f43ef92469ebc8605013728c8950e7608439f01d13678994f0ce101c3a8')
+
+    ASSET_FLASH = Asset(
+        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/sx1/flash',
+        '17e6a2758fa38efd2666be0879d4751fd37d194f25168a8deede420df519b676')
+
+    CONSOLE_ARGS = 'console=ttyS0,115200 earlycon=uart8250,mmio32,0xfffb0000,115200n8'
+
+    def test_arm_sx1_initrd(self):
+        self.set_machine('sx1')
+        zimage_path = self.ASSET_ZIMAGE.fetch()
+        initrd_path = self.ASSET_INITRD.fetch()
+        self.vm.add_args('-append', f'kunit.enable=0 rdinit=/sbin/init {self.CONSOLE_ARGS}')
+        self.vm.add_args('-no-reboot')
+        self.launch_kernel(zimage_path,
+                           initrd=initrd_path)
+        self.vm.wait()
+
+    def test_arm_sx1_sd(self):
+        self.set_machine('sx1')
+        zimage_path = self.ASSET_ZIMAGE.fetch()
+        sd_fs_path = self.ASSET_SD_FS.fetch()
+        self.vm.add_args('-append', f'kunit.enable=0 root=/dev/mmcblk0 rootwait {self.CONSOLE_ARGS}')
+        self.vm.add_args('-no-reboot')
+        self.vm.add_args('-snapshot')
+        self.vm.add_args('-drive', f'format=raw,if=sd,file={sd_fs_path}')
+        self.launch_kernel(zimage_path)
+        self.vm.wait()
+
+    def test_arm_sx1_flash(self):
+        self.set_machine('sx1')
+        zimage_path = self.ASSET_ZIMAGE.fetch()
+        flash_path = self.ASSET_FLASH.fetch()
+        self.vm.add_args('-append', f'kunit.enable=0 root=/dev/mtdblock3 rootwait {self.CONSOLE_ARGS}')
+        self.vm.add_args('-no-reboot')
+        self.vm.add_args('-snapshot')
+        self.vm.add_args('-drive', f'format=raw,if=pflash,file={flash_path}')
+        self.launch_kernel(zimage_path)
+        self.vm.wait()
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.34.1


