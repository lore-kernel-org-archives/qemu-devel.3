Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41513D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5ntl-0002Uf-35; Tue, 29 Oct 2024 11:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5ns7-0000hu-B9
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:04 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nrz-0007gP-Jz
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:11:00 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-539e8607c2aso5719945e87.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214653; x=1730819453; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zZy//cWTdf5wvz+1/D1caLV6ihJzmgvgWerEXZ8yj5Y=;
 b=syeCpO9f12SiDBryP6+JyBXhy8JEdfzauTmN7AZKRD7XmCaDc9MBd1MjVmQqukLnog
 NPfBm+GL+eBVVM+UeObEV43du6ASsJQSjrSNLUxEuKy7odtWEKzbRV1pHZlEc53gYlF2
 MbcA8nDtvH5mulmP9ew/L/J6027VvtOrInF9OHYbqVG5bXBeXHNYwA8hGtthy6YM1DB5
 BKAAOUg62QXimuJoM0Q7jwI/fe+VFmAVsiT/SQt/sDbPLMPkUt1BCy9turPznNN1m9yD
 QhWmQfi/1WVSbGeVdRMVkVZweVJZdrgzEW79nrIvUWOewo5Ap5vs0Ha2gp1aczzMV8Lu
 Vh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214653; x=1730819453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zZy//cWTdf5wvz+1/D1caLV6ihJzmgvgWerEXZ8yj5Y=;
 b=Nt6t73R0/4V5bM+1CyWYKp75vfg14laHyxDCDTvXryIFQEw9NIZaD2WyW2F7ft/Yf8
 /hqN9FIkkNGkku0IZ28CIP8inEQeTtGblHqctUELLXNQOdU38GEnwaz1HyHpu4s50nm6
 pEp/VV29x/vmOL+gW+V5lhnsrJm3/XnuE4Sl9eaoTVl4vAUl8Ice5En3ZuMu3GewpgTy
 J1iGbiyiWjCqUf72R0OB4uvH5cVbJLvPlhj+dqHq6uKjBn2sbAtTys1bhHVHuEOJUinK
 eG843vTzNyqovAPuch4OWr6zusQ7iCzlt3Gm+TPskW/AMl5vLwggJXTH+OuiCWIgaEk0
 uY7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyFD5hJjr9WkJB++fwrYRPLrQ/JfPYY6WlQJTcWEo/SmGND4SYa4aBPwgTExM+6ldw4V4M8EWaU/Jj@nongnu.org
X-Gm-Message-State: AOJu0Yz1o8r7YMYDePQCEC8o5ISmKQ8oUQinUbMxVuFi9bM3bgKS2vH5
 InYyBV9a8MYvcBqjb4RS0rqyjss3LpRc6pHmq+gkKkNXYZ4FNnfOjb/ogFtDDZU=
X-Google-Smtp-Source: AGHT+IHb7dprb9Ub/lE5ReRqSy5xWU07ypTu+NwilAcXszWXjMmU+xF1vt6k+e00GpaAyvL+cINwKQ==
X-Received: by 2002:a05:6512:15a9:b0:539:ecef:376d with SMTP id
 2adb3069b0e04-53b34a33d05mr5926085e87.54.1730214653099; 
 Tue, 29 Oct 2024 08:10:53 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 06/18] tests/functional: Add a functional test for the collie
 board
Date: Tue, 29 Oct 2024 15:10:36 +0000
Message-Id: <20241029151048.1047247-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

Add a functional test for the collie board that uses the kernel and
rootfs provided by Guenter Roeck in the linux-test-downloads repo:
 https://github.com/groeck/linux-test-downloads/

This just boots Linux with a userspace that immediately reboots
the board, so we wait for the reboot log line.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20241017163247.711244-2-peter.maydell@linaro.org
---
 MAINTAINERS                         |  1 +
 tests/functional/meson.build        |  1 +
 tests/functional/test_arm_collie.py | 31 +++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+)
 create mode 100755 tests/functional/test_arm_collie.py

diff --git a/MAINTAINERS b/MAINTAINERS
index f48d9142b8a..6b1fa225d6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -929,6 +929,7 @@ F: hw/arm/strongarm*
 F: hw/gpio/zaurus.c
 F: include/hw/arm/sharpsl.h
 F: docs/system/arm/collie.rst
+F: tests/functional/test_arm_collie.py
 
 Stellaris
 M: Peter Maydell <peter.maydell@linaro.org>
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 97c1c597e86..9538e103d6e 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -54,6 +54,7 @@ tests_alpha_system_thorough = [
 tests_arm_system_thorough = [
   'arm_aspeed',
   'arm_canona1100',
+  'arm_collie',
   'arm_integratorcp',
   'arm_raspi2',
   'arm_vexpress',
diff --git a/tests/functional/test_arm_collie.py b/tests/functional/test_arm_collie.py
new file mode 100755
index 00000000000..7e144a0a8fb
--- /dev/null
+++ b/tests/functional/test_arm_collie.py
@@ -0,0 +1,31 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a Linux kernel on a collie machine
+# and checks the console
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import LinuxKernelTest, Asset
+from qemu_test.utils import archive_extract
+
+class CollieTest(LinuxKernelTest):
+
+    ASSET_ZIMAGE = Asset(
+        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/collie/zImage',
+        '10ace8abf9e0875ef8a83b8829cc3b5b50bc6d7bc3ca29f19f49f5673a43c13b')
+
+    ASSET_ROOTFS = Asset(
+        'https://github.com/groeck/linux-test-downloads/raw/225223f2ad7d637b34426810bf6c3b727b76a718/collie/rootfs-sa110.cpio',
+        '89ccaaa5c6b33331887047e1618ffe81b0f55909173944347d5d2426f3bcc1f2')
+
+    def test_arm_collie(self):
+        self.set_machine('collie')
+        zimage_path = self.ASSET_ZIMAGE.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+        self.vm.add_args('-append', 'rdinit=/sbin/init console=ttySA1')
+        self.launch_kernel(zimage_path,
+                           initrd=rootfs_path,
+                           wait_for='reboot: Restarting system')
+
+if __name__ == '__main__':
+    LinuxKernelTest.main()
-- 
2.34.1


