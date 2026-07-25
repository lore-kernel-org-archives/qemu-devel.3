Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F64C53200
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnQmw-00025y-Iu; Fri, 24 Jul 2026 21:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTU-00073j-8P
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:45 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnQTS-0000tQ-Nz
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 20:42:43 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-73a8ac9cd52so688681137.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 17:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784940162; x=1785544962; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HnQ7gxsV8OdqblNm0oJhx5jgthosF7mosNZcLoe2o7k=;
 b=LAVKsSlTyqSNiXURUPMXXvKMonZ+8KENuAyu3ACHS8fymxD2xPboBzVTLfYZnz7pfq
 zl0qOcPQ45I5OxWfhI+heqSFyiqliWTsISSeAULtsCsLKQZtjK5JWcyTIDg9CejZYr0b
 EEM38bgtEsmKKP60A2WcfFb9tTDZCDqkhe/NtXo0vnhk7C5gWTg2LCUjzHiHw5PyYPRV
 Ik2gz08xlLneEi1Ziqx9R2DJpSLGTT8sG8bFT3lBht1iYGc5nJsZsf1+zYWvxFvKndOK
 6fBn3+9b7MG1uoi9HotUmpeVvRR3AsEeDVKNnxvXvq/DO2l7KM/GocfHK9Rtwt4oYp92
 F8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784940162; x=1785544962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HnQ7gxsV8OdqblNm0oJhx5jgthosF7mosNZcLoe2o7k=;
 b=aINrUM8wgdq5x0eInKHA5687Z6orjR2KRq16OfuCg99KtxJH6W0VAOZUdOODZ+i5p5
 8QUZOxZLqrgA98sy1tj9LIooJ1w00S4R/QNj8y+nxfXJAiXodKMYNYtBgh3LOJE/LfjD
 /6nYCE7oV8fPO28ZSHDK2edwx3MO44JAejAxbaSfUxgOmgFw716EaAeVXn67m3pHX7Dz
 +j5WKL7huI/QoPssXfU6swE1/WoLk/8XzUCdKUB52YCpRikPR/Qm50Kz4hpG3HiCS7Nu
 H73jbA/Szsjlhf+nPIfd9shKQtiog+gKaN7mSQOHGhPmAr/sZOmLW9Tl3hnDWXp14omS
 OqPg==
X-Gm-Message-State: AOJu0YxIfOy5EibkGyWWb0nWUHYBuVOT6za6xhdeYU18vbX5WuM2yHhh
 495/NWU5AUHIrUsoVCnprYqrfcEefglQGWsYX4PIC4ziICObOrsA1k+51HztImiY
X-Gm-Gg: AR+sD11JfEXGChNe1k28z19Yra2McMDQmjq/F0ThvvPgo3sLzuBb+SwA7/AT0sBJuqM
 Ue8oSrbGK3avJ94+cMKWwxvM5h2xq+jPI5S59mBWoxTx+IZ4VoeuYCgCcIrz/50uj33I4HWZ/x9
 eNq77WU+15Cd47dteoKv9t1zUbDbuHyHQOC1E/bTlZqwhlRPLO5d6T95UYfVIrrtOoZMbsjMA4q
 s42TgmXDPyTWWnXwobxIKQ+TaRCv4AWm/AjNk3PV5qJYMa7Iu+aqyuhYevY3qyd5rcUcI5R5tbc
 Eb6J9+zfdlQY9/nPf3nxBEERwVnDs1VzWrn7ufb4muoiRufD3JbaGsgNa9BjNwK6rGwk3AmcUgX
 LTkVa4rMl4hDEw7NX/U1bZ506LeU/Sk5tPOSkRlxPJHLXxtwMuyH8Dr+dHzNhD2hfIpn0EbYweI
 mjf0niqTwrAzN0adgepBdTNlvrSJR6BHIs
X-Received: by 2002:a05:6102:a210:10b0:6cd:b43f:72fd with SMTP id
 ada2fe7eead31-74f9fc68fb5mr1307052137.22.1784940161607; 
 Fri, 24 Jul 2026 17:42:41 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774f12690sm930591241.12.2026.07.24.17.42.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 17:42:41 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jason Wang <jasowangio@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 19/19] tests/functional/aarch64: add raspi4b GENET networking
 test
Date: Fri, 24 Jul 2026 20:42:18 -0400
Message-ID: <20260725004219.66222-20-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725004219.66222-1-marcelomanzo@gmail.com>
References: <20260725004219.66222-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vs1-xe2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 24 Jul 2026 21:02:41 -0400
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

Add test_arm_raspi4_genet, exercising the raspi4b GENET controller
end to end: boot with a -nic bcm2838-genet device attached, confirm
the guest driver probes it ("GENET 5.0 EPHY" in the kernel log),
reach a shell, and confirm the link actually comes up
("ip link show eth0" reports LOWER_UP) rather than just that the
device exists.

Verified locally against this series with the exact kernel/initrd
assets this file already pins (raspberrypi-kernel_1.20230106-1 /
groeck linux-build-test rootfs): without the "fix PHY
autonegotiation-restart deadlock" patch earlier in this series, the
link never comes up and this test would hang at the "ip link show
eth0" step, so it also serves as a regression test for that fix.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 tests/functional/aarch64/test_raspi4.py | 30 +++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index 7a4302b0..0e254a20 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -92,5 +92,35 @@ def test_arm_raspi4_initrd(self):
         #self.vm.wait()
 
 
+    def test_arm_raspi4_genet(self):
+        kernel_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                           member='boot/kernel8.img')
+        dtb_path = self.archive_extract(self.ASSET_KERNEL_20190215,
+                                        member='boot/bcm2711-rpi-4-b.dtb')
+        initrd_path = self.uncompress(self.ASSET_INITRD)
+
+        self.set_machine('raspi4b')
+        self.vm.set_console()
+        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
+                               'earlycon=pl011,mmio32,0xfe201000 ' +
+                               'console=ttyAMA0,115200 ' +
+                               'panic=-1 noreboot ' +
+                               'dwc_otg.fiq_fsm_enable=0')
+        self.vm.add_args('-kernel', kernel_path,
+                         '-dtb', dtb_path,
+                         '-initrd', initrd_path,
+                         '-append', kernel_command_line,
+                         '-no-reboot',
+                         '-nic', 'user,model=bcm2838-genet')
+        self.vm.launch()
+        self.wait_for_console_pattern(
+            'bcmgenet fd580000.ethernet: GENET 5.0 EPHY')
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(self, 'ip link show eth0',
+                                                'LOWER_UP')
+        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
+
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.47.1


