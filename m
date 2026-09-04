Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC5CC79F81
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MLp-0005mz-NH; Fri, 04 Sep 2026 01:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLd-0005cD-G3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:21 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MLb-0001GP-RZ
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:20:21 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so439917b3a.2
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499218; x=1789104018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T2E4eZy1lxrFV6bxZBSW81kPJKqq9XAesjbsqlY8Y44=;
 b=Im3NHJ/zW1WZOxuRtz4sr1IoPnEFzKk6Xhp7jFodUALcIIc6JWu0SlpOzif8abd/fh
 XTOtWNByCx/1iYWPbDn8Aa+oB16FniojJnnHMmCugCceiV+XO4EbouFU4w891nhswX7i
 hKEyCUGlQhzsoRXsi8Eu6kwUjbiX4p05gDkn6CjYXmy52++mEqzVys6RvfYqcIqC8J8l
 SSzvDdt7anLT+ZirCU8ArTdsGnsqYTM90BuZPWuh7BeBxLbnYV6CoSl/YBGKS7cjmOi4
 k9mcUUgcJTGZkSV/9xWlbeD5ChydmnZdQoPL1oMtb/x4WJYnCZs/j7HwamaXTmErNlsG
 jarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499218; x=1789104018;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T2E4eZy1lxrFV6bxZBSW81kPJKqq9XAesjbsqlY8Y44=;
 b=epiU/XMGJC+kyXcByzSmDsP0E7Aid8xTvUopGORkf49rKTjKJldn7ImnfJISMcwWDU
 DjbC5pG9ic17NLwsQTKzEekJ3tZabrkFuxfWb8GydKxYf9cv84HIliOqe6Vdz/v4sJT2
 psBTrP84WVrweEx5UGAInKoWfI478v4XQbEemH+e7KcHBQ97oFN2B/R7aGKAQyXfVyfn
 IsbYLtYCdGS41uizzCSdUeymIwNA/eHFFQf0FVmZANppE4MTaZExwhvpLnm0oN9Eq9/r
 NLaJW6cebAX6rJA1hTQn2hw/GVOSWrmbZjxSRlz8UddGXrv1Ptga7Zyoc7DSjEt+QCLk
 dfOA==
X-Gm-Message-State: AFuF++mcFSepDWVTFO1DndKLYlKq9Dc5uKizV134t7TjAf6PPnyqbP1R
 7pS5jhJN9ax3jdspwvT/AR3rLybjahDgEjkqoQq7fuXQnisM++UOkprSQgjYCw==
X-Gm-Gg: AYBFou3RLw3sFQwRTlL4zNmj6WDWQyNvCitydUCN/abn1vef3eBgJHuPaFCa7reitLp
 guMHP7hHJbAJjIUiAOLfYTTqXTpC5O/mieLqEGj2aaPevTOZw1NcpOxhyZd46+Es61XIUbfes2S
 wNtWO0qBGpOnJ+VaSO7RXbicbacJzV9UqIO7gdBryzWSCG0xgQrNvN9/ieYWQREOb8tyamjiMKx
 Xv17EnP4iKkH5a102BJIpy76iMy1WazuDTzckZ6I29Bf/nAPFa68+g+4nin0ScBkX6MjM4n8NZx
 GiQF6ggFmXSY6oXgD5xbeKydjmWP/5dNBdMF9p/UdWb5xS4V1w2fsVv1g7F4y9JstaUNPyBSGxa
 oB18LVknjm0dOdAVlFc3v8Sn/L9fO7+Rw0R2FdXChKjgzT7NhNZJJrfAZiBqa+cEfJJqBc3Begl
 1/mfpFM3Hrp9T/S+qSeV7DvQoYXFqvwwv3POl7/YlgIRi3mjT/fpSS7VfiKP787+zPr872Ak8Y9
 FZ/o56UpewuT1uC
X-Received: by 2002:a05:6a21:487:b0:3c3:9df0:2d66 with SMTP id
 adf61e73a8af0-3da39b71849mr5458480637.6.1788499218439; 
 Thu, 03 Sep 2026 22:20:18 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.20.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:20:17 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 08/47] tests/functional: Avoid unnecessary removal of scratch
 files
Date: Fri,  4 Sep 2026 15:19:04 +1000
Message-ID: <20260904051943.799041-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Joel Stanley <joel@jms.id.au>

Files written by uncompress() and archive_extract() are placed in a
temporary directory that is cleaned up when the test exits, making
os.remove() redundant. Drop it and the unused os import.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260824055642.41098-4-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/functional/arm/test_bpim2u.py       | 11 -----------
 tests/functional/arm/test_orangepi.py     |  9 ---------
 tests/functional/riscv64/test_sifive_u.py |  4 ----
 3 files changed, 24 deletions(-)

diff --git a/tests/functional/arm/test_bpim2u.py b/tests/functional/arm/test_bpim2u.py
index 8bed64b702..9192a2fbec 100755
--- a/tests/functional/arm/test_bpim2u.py
+++ b/tests/functional/arm/test_bpim2u.py
@@ -5,8 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
 from qemu_test import Asset, interrupt_interactive_console_until_pattern
 from qemu_test import skipBigDataTest
@@ -54,8 +52,6 @@ def test_arm_bpim2u(self):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
-        os.remove(kernel_path)
-        os.remove(dtb_path)
 
     def test_arm_bpim2u_initrd(self):
         self.set_machine('bpim2u')
@@ -86,9 +82,6 @@ def test_arm_bpim2u_initrd(self):
                                                 'reboot: Restarting system')
         # Wait for VM to shut down gracefully
         self.vm.wait()
-        os.remove(kernel_path)
-        os.remove(dtb_path)
-        os.remove(initrd_path)
 
     def test_arm_bpim2u_gmac(self):
         self.set_machine('bpim2u')
@@ -133,9 +126,6 @@ def test_arm_bpim2u_gmac(self):
                                                 'reboot: Restarting system')
         # Wait for VM to shut down gracefully
         self.vm.wait()
-        os.remove(kernel_path)
-        os.remove(dtb_path)
-        os.remove(rootfs_path)
 
     @skipBigDataTest()
     def test_arm_bpim2u_openwrt_22_03_3(self):
@@ -174,7 +164,6 @@ def test_arm_bpim2u_openwrt_22_03_3(self):
                                                 'Allwinner sun8i Family')
         exec_command_and_wait_for_pattern(self, 'cat /proc/iomem',
                                                 'system-control@1c00000')
-        os.remove(image_path)
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
diff --git a/tests/functional/arm/test_orangepi.py b/tests/functional/arm/test_orangepi.py
index f9bfa8c78d..0978023655 100755
--- a/tests/functional/arm/test_orangepi.py
+++ b/tests/functional/arm/test_orangepi.py
@@ -5,7 +5,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
 import shutil
 
 from qemu_test import LinuxKernelTest, exec_command_and_wait_for_pattern
@@ -65,8 +64,6 @@ def test_arm_orangepi(self):
         self.vm.launch()
         console_pattern = 'Kernel command line: %s' % kernel_command_line
         self.wait_for_console_pattern(console_pattern)
-        os.remove(kernel_path)
-        os.remove(dtb_path)
 
     def test_arm_orangepi_initrd(self):
         self.set_machine('orangepi-pc')
@@ -97,9 +94,6 @@ def test_arm_orangepi_initrd(self):
                                                 'reboot: Restarting system')
         # Wait for VM to shut down gracefully
         self.vm.wait()
-        os.remove(kernel_path)
-        os.remove(dtb_path)
-        os.remove(initrd_path)
 
     def test_arm_orangepi_sd(self):
         self.set_machine('orangepi-pc')
@@ -140,9 +134,6 @@ def test_arm_orangepi_sd(self):
                                                 'reboot: Restarting system')
         # Wait for VM to shut down gracefully
         self.vm.wait()
-        os.remove(kernel_path)
-        os.remove(dtb_path)
-        os.remove(rootfs_path)
 
     @skipBigDataTest()
     def test_arm_orangepi_armbian(self):
diff --git a/tests/functional/riscv64/test_sifive_u.py b/tests/functional/riscv64/test_sifive_u.py
index 54a0f9c648..6bf5be15f9 100755
--- a/tests/functional/riscv64/test_sifive_u.py
+++ b/tests/functional/riscv64/test_sifive_u.py
@@ -10,8 +10,6 @@
 #
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-import os
-
 from qemu_test import Asset, LinuxKernelTest
 
 
@@ -49,8 +47,6 @@ def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
         self.vm.launch()
         self.wait_for_console_pattern(pattern)
 
-        os.remove(rootfs_path)
-
     def test_riscv64_sifive_u_nommc_spi(self):
         self.do_test_riscv64_sifive_u_mmc_spi(False)
 
-- 
2.55.0


