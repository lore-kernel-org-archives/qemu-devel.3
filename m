Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F33C87FCB
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Aug 2025 14:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulpcF-0007Vr-J7; Tue, 12 Aug 2025 10:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpcC-0007U2-RX
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:04:36 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ulpc9-0007k3-8Y
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 10:04:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3b8de193b60so3121927f8f.0
 for <qemu-devel@nongnu.org>; Tue, 12 Aug 2025 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755007467; x=1755612267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f93tv/vnA/xMKC2H8Wzbvol4EZUoCD7p17vWtC4FtnY=;
 b=vxLtc4ClBBCAbLbliwO474bDs7e+Nws+R/O2QjUw/tFTym8hgK27XomsK/vVyvBQac
 FqJ8V4am/HsKvlY9meMyHlvFu0QP0jpBNfVaPQere6EFnl1qe+zmFIC4h2i5azVhM/xd
 2CJYYP+ma0EbPBTDRq/yR2FMoQ5RNsNCSZwtYQKMbTaJ1N+2WHxLo7V6+3ANt3vj8qUB
 p7zp+xnTtK4oi27+7EsVACZXCgtqmW4JXNHH/k8pM1eXWKa5zFJs1Lwq8PrY/cFdzHCA
 L1MvlOMRfEjDtoXIe/Ai6/w88duncMADka3sUfZhv3Qmhzsg1S2YfOhximhUdcQHOqC9
 IIuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755007467; x=1755612267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f93tv/vnA/xMKC2H8Wzbvol4EZUoCD7p17vWtC4FtnY=;
 b=hecCEz8eoVTnxfLGxYiIfa+zGXVDIeQsKuDu/AoPjHClGU6MxdL0r6qGvFwKS38t1S
 ugz6P38qiIdtEEQYmgwEgEjEx7euGKM6a8/qpoz5l+o6ctAotbCTv8Tl4zbT/ci8e1Db
 yO9soFXNmzX5O9++tWLhMoEob5yhqYJRniqpd1TwFx/9vQYFW4PAw8FW9A8fj4EkVjVP
 vx7PrRosivyq1FGFwAXSV+EE2mAcefXh4khXyramrYnUbRHm4AOJfwgy19kkdSHHYYcM
 0p6RSGQd6hk/3+itW0a25nx9wqXhjc5nds4vg6ISqpR+EWi4Pybr6/Y6gacfKzjVC3IY
 E/AA==
X-Gm-Message-State: AOJu0YwPzQEjisiDjJL+gU7u3MrDQv0SahRvXQHoqEjE3TVDyuln2S5i
 G2kKehqmzSMoXlFHrFHi2368K9ghsTKVrOeeAhGaaQ7BneXAlSJnQwAUUkzPtndqMk842JW4sYt
 nqYxa
X-Gm-Gg: ASbGncuQMOMLbsLJaftbZdpWfr+g7sI4nP1PYos428dFIvrob/N+SndzHYXF1zVQlFO
 aKYpfQ8TJDfUVwGY1oSERlVcJnYtqyheeWOnaHiDh1u/hoMQSmqzjqqONayIX09SvMXaxhxuHlZ
 cb+dJQdL/VRNqFbImAbHcjzanjHwh/pkb320Yph6ex0V/zG0+TR/Rw78IOP9mKd4ASkk/9FnM0Z
 tdpsZe7kZS8AiSHoK/hAC8jYxdvqCpdAfFYqnuykgRTb40LKiK5R+UDuWXICMvR5XUF2/2acpgp
 aeFOEKtEIp7xwlsLl/OJgPsQlYzMhY21Y9hg8AmVow1NH81U+NpGtPOo1Bv8KCy/TTUXCVZ9SaP
 zqq2dxBw7mYJtqoFATy53ZieY9tqEP8batUgm0+c8M9zBPyO8W5jxo92lnBPMS3LQj6R+R+01
X-Google-Smtp-Source: AGHT+IFwaqA8DGx2N7QECxFWYEBb2K+QjE1qQT79J/Fzs77ogahZmTVE3Xvo4xLzF78FRFwBM+4RsQ==
X-Received: by 2002:a05:6000:2304:b0:3b9:10af:59f2 with SMTP id
 ffacd0b85a97d-3b911014ba4mr3054328f8f.28.1755007467124; 
 Tue, 12 Aug 2025 07:04:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c453333sm45923437f8f.45.2025.08.12.07.04.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Aug 2025 07:04:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH-for-10.1 RESEND RESEND v2 2/3] tests/functional: Test SPI-SD
 adapter without SD card connected
Date: Tue, 12 Aug 2025 16:04:14 +0200
Message-ID: <20250812140415.70153-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250812140415.70153-1-philmd@linaro.org>
References: <20250812140415.70153-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

SPI-SD adapter should be usable, even without any SD card
wired. Refactor test_riscv64_sifive_u_mmc_spi() to make it
more generic and add another test, inspired by this report:
https://lore.kernel.org/qemu-devel/5b2dc427-f0db-4332-a997-fe0c82415acd@roeck-us.net/

Inspired-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/functional/test_riscv64_sifive_u.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tests/functional/test_riscv64_sifive_u.py b/tests/functional/test_riscv64_sifive_u.py
index dc4cb8a4a96..ca4c3ba6e12 100755
--- a/tests/functional/test_riscv64_sifive_u.py
+++ b/tests/functional/test_riscv64_sifive_u.py
@@ -27,25 +27,37 @@ class SifiveU(LinuxKernelTest):
          'rootfs.ext2.gz'),
         'b6ed95610310b7956f9bf20c4c9c0c05fea647900df441da9dfe767d24e8b28b')
 
-    def test_riscv64_sifive_u_mmc_spi(self):
+    def do_test_riscv64_sifive_u_mmc_spi(self, connect_card):
         self.set_machine('sifive_u')
         kernel_path = self.ASSET_KERNEL.fetch()
         rootfs_path = self.uncompress(self.ASSET_ROOTFS)
 
         self.vm.set_console()
         kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
-                               'root=/dev/mmcblk0 rootwait '
                                'earlycon=sbi console=ttySIF0 '
-                               'panic=-1 noreboot')
+                               'root=/dev/mmcblk0 ')
         self.vm.add_args('-kernel', kernel_path,
-                         '-drive', f'file={rootfs_path},if=sd,format=raw',
                          '-append', kernel_command_line,
                          '-no-reboot')
+        if connect_card:
+            self.vm.add_args('-drive', f'file={rootfs_path},if=sd,format=raw')
+            kernel_command_line += 'panic=-1 noreboot rootwait '
+            pattern = 'Boot successful.'
+        else:
+            kernel_command_line += 'panic=0 noreboot '
+            pattern = 'Cannot open root device "mmcblk0" or unknown-block(0,0)'
+
         self.vm.launch()
-        self.wait_for_console_pattern('Boot successful.')
+        self.wait_for_console_pattern(pattern)
 
         os.remove(rootfs_path)
 
+    def test_riscv64_sifive_u_nommc_spi(self):
+        self.do_test_riscv64_sifive_u_mmc_spi(False)
+
+    def test_riscv64_sifive_u_mmc_spi(self):
+        self.do_test_riscv64_sifive_u_mmc_spi(True)
+
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.49.0


