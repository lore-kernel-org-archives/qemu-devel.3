Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55521C87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Aug 2025 13:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukNVu-0003im-0s; Fri, 08 Aug 2025 09:52:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNVN-0003aO-MW
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:51:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ukNVK-0002Hz-Ih
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 09:51:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-459d62184c9so13258875e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 06:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754661087; x=1755265887; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5l7n3D9ctZbGZm4ngX5c30d2jXCKAPPPYSiErk+U9JA=;
 b=ta3vhjwLZFf5A9TsOptl2/6EW7gKCzTL5GqybHhKJ4r/ip2yf8KuNanoQMKmLeeSld
 qYnqANjQnZdhgYjv80OIZwsZ0DqSar+caYJ5uoGS0N18oMvP14es9hI0kyWRg43qZqql
 9Q7ZjqmwItiMh9oY21Weta5xm/Ker7R2aoTJ/AMk2/5OwBDXHGCGvDY3w+BIBu6/1gCy
 P8BOBH2mGPpx/zaGnEvelVJr03q6ytCZwIHfIsepnd1gfq9Z8uxEESUcpPNaKj5JsjVR
 DrFM3i813kJf/uXqmxiW26Cpqty15n/P6x+89tcSSli1onjjxqI+mSVFCgXBlg0DbixR
 wkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754661087; x=1755265887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5l7n3D9ctZbGZm4ngX5c30d2jXCKAPPPYSiErk+U9JA=;
 b=eb8kvUG6GbKFOOQW8iIJAHmcha0R+6/4i5Maw1eWViD8vFIOxE9txwbOT4OZC5AO3f
 FaSxi4UmnepwocO9DKumMisqIuvgDsloeGsl6W1S1aUaFPSuUt7gnIxQDmYO/dMQp3XC
 f9NlyT/ooULW/XeL/szU7STmJOhF0wlDNvxRHFxZCbHXfHcQtzwNb1GW7uEAZ6+x0kBS
 GoXPbMUjxAaloVYQUJNCvfMWRkE5VG6Xm2B9drixAoY1Y4l+LmsAPaw43E9l0Y9GEoZb
 4Qh+4xTotXEnBfPB9K8VBedVmBeTuRs4QgewwoqCpqcqalb1iXenG1D7jW4bvIH7pfv0
 yTAw==
X-Gm-Message-State: AOJu0YxCeM1O75wN99vcrRinysjMqiRvYfksxNiVei91GjpeO3nj7zr2
 K0C/cStBC8aQhKAnxmfYrLMG3wqnfSM/1GMqCEj71gUr90052roDrhyEHFLkjCV5QvvYXbE1iIS
 ltq8H
X-Gm-Gg: ASbGncsFOJFSulgvJGEMM1eqtEoKJJa18HblU/h6GdfZjfawlzAdDjn4Bxg7u67mtZE
 4o4EMgknHaPobAigxAxGAlGZK79gZMcbBNidX2VjFZsSj2ssYCQfwKsCTshpKdyDN7FI3VLkZ6c
 zQCqCaEsWuMebpSwuVcTKvtaWf70/IsQ25H5EoDA2qvuqg63qwJAXdhwu2oHtCQiOvgGt5Kho+X
 6RhQJY2bDuRHyhfRhh0OAIbZ86ur3GpmOJrEUWPoYQG8IZzl/CdNyl5xyYnjX1bHBP5liICcyhB
 2YGaguMIDvu03DeMzahVv5XHjBzjGDuaWwFMZAI2tsqWPazXGla3PN5hE9+aliU/qLs8cPR0GTZ
 BF5D9vUU276UU3bn7NHb3DHlq0cBJJrbK7WBABg7WCnSbW7EFostw30ER72GpKRHepFafHhPm
X-Google-Smtp-Source: AGHT+IHjP+LfvGq0+GFppwTBcfZwQeILlxu//QZAS1Vn2mW1Idvjp5FeSBKD1eY8d2GZM727Rjua+g==
X-Received: by 2002:a05:600c:4449:b0:459:dfde:332e with SMTP id
 5b1f17b1804b1-459f4f1447cmr25906755e9.29.1754661087139; 
 Fri, 08 Aug 2025 06:51:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e9464f46sm16174067f8f.19.2025.08.08.06.51.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Aug 2025 06:51:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Guenter Roeck <linux@roeck-us.net>, qemu-riscv@nongnu.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-block@nongnu.org
Subject: [PATCH-for-10.1 2/2] tests/functional: Test SPI-SD adapter without SD
 card connected
Date: Fri,  8 Aug 2025 15:51:15 +0200
Message-ID: <20250808135115.77310-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250808135115.77310-1-philmd@linaro.org>
References: <20250808135115.77310-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
index dc4cb8a4a96..f7ab1abfd56 100755
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
 
+    def _test_riscv64_sifive_u_nommc_spi(self):
+        self.do_test_riscv64_sifive_u_mmc_spi(False)
+
+    def test_riscv64_sifive_u_mmc_spi(self):
+        self.do_test_riscv64_sifive_u_mmc_spi(True)
+
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.49.0


