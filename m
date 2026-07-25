Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75400C531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 01:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnRAC-00052I-Tg; Fri, 24 Jul 2026 21:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnRAB-00051r-3m
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 21:26:51 -0400
Received: from mail-vs1-xe31.google.com ([2607:f8b0:4864:20::e31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1wnRA9-0006Gz-N4
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 21:26:50 -0400
Received: by mail-vs1-xe31.google.com with SMTP id
 ada2fe7eead31-726840fb461so256995137.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 18:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784942809; x=1785547609; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bJ2r/gMDRkwdyWL70QN40YSq4nEajyBo622BX23Tmqk=;
 b=gg6BEe9ikmCbnRRq6W+OTvT1k920os2O48Y6SDlLmP76yp2TT2xyaxcCQ5TJIohNab
 TjJHWHguVmZ3AbbhGQcIF2FThsaFoU6D+oX2uEX2rW10OGmEiOv0tm1MLuEFhdTH4Zz2
 whQLjVchAet+YX6XAzrUGZd/64jbPMuYdl3aioX5aJ8a51rVdfebAHQZwe+dv3J8MDMk
 NosVQyxr4GlJcWN0bNaD/EpmRp0cZ9j7tkzldGPN/0HGcDZEKqaJbf1kS30Akbbl5f6x
 TsDrUJVOuIboBALzo2FqNZKFaC3LF+canFo2rumpSe+YNRvjrH7a3BgdjClgFwjm1Mjm
 dhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784942809; x=1785547609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bJ2r/gMDRkwdyWL70QN40YSq4nEajyBo622BX23Tmqk=;
 b=NeSyddI7r2VKy6QJvwLeUYF+/7W1NLRwdM6EpwfllIZRDqzzWd9qRvx3ZBLjrxMV0/
 lKoWWLflz78lp3gtVhBZczPRVqwPj9EX1YlXGvF+/8wDmqftRJfO5bWpSNkEex8NPIGv
 Q7BJnqHW2azUaxfhKKJFrfIIYUcz7wNMzvYm6HOjHYo1rmO18ZdSLW+cWvYa7AZx1A6B
 0tOOKLwkR0cGAA/NI/6c4FxKQyUWKcA174oIneHX/gvohgAfRu/RSL+ChG0YEfjW306P
 t+yx6HD5CoSOdqTchDANw6Jo8PAmSeJnbCQQKmysZN89syTDqRP9wgORTKsvKnQinMlx
 e5dw==
X-Gm-Message-State: AOJu0YxltZZqvD8Vjg5fOlNKmzroNyjrxblO6ycU0AVMst8znHIqgQBG
 iLsoGie9WUJiW1qeHOl4xq1lN5riWx30nik+iKATpBycpo93dFLytPyW+YOC+1Ga
X-Gm-Gg: AR+sD13jr748lORzximIBWay4fhnLhZ5LImMufJuX2ynDCkTE2bZWyDszASKH0a4Tev
 HETTrEVcTur9R2LJO+GS/Ajhrb4NqJshzHfqUdAvgDUoVDBF4BG9meFL47ipiKQ0EN7MtMnGbhn
 OUieAiBMXN8UqLMt84wpvnvEXhy1vTHSz4wVhyytJCCdBHYllP+h63YWlPttnyX13VsNoj1RhN6
 i5nkUG7sA0vKkswKqBSdl/G7nlaImOdMVEsRVrXafLbCEmNrqebmJNPkamOhvs0ki6hL7UUCRn+
 WQXzIt5ozii+wQNbXSq1NRLzUtb5r6TjrcdOXtViN8XV/CDMC6blkr9aiZKgf1/EuVXRkzNq6wr
 pwsYEabQEuPBD3utFZMNOohDizOPmQR1jLFQPeEFzXyEaFs/msYKJkF2fLqxW5F7yiuq8gdAXq7
 FkaI3RuzMB961BtC+Et9XlK57iNmN1Zk2Z
X-Received: by 2002:a05:6102:3711:b0:739:8c52:f2b with SMTP id
 ada2fe7eead31-7503fb97f37mr727666137.18.1784942808639; 
 Fri, 24 Jul 2026 18:26:48 -0700 (PDT)
Received: from localhost.localdomain ([146.71.8.128])
 by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-97774c388d7sm1092856241.1.2026.07.24.18.26.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 24 Jul 2026 18:26:46 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH 5/5] tests/functional/aarch64: add raspi4b RNG200/thermal test
Date: Fri, 24 Jul 2026 21:26:35 -0400
Message-ID: <20260725012635.4925-6-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260725012635.4925-1-marcelomanzo@gmail.com>
References: <20260725012635.4925-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e31;
 envelope-from=marcelomanzo@gmail.com; helo=mail-vs1-xe31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add test_arm_raspi4_rng_thermal, exercising the raspi4b RNG200 and
thermal sensor devices added in this series: boot, confirm the
RNG200 driver probes it ("hwrng registered" in the kernel log),
reach a shell, and confirm the thermal zone reports the expected
fixed reading and /dev/hwrng actually yields data rather than just
existing.

Verified locally against this series with the exact kernel/initrd
assets this file already pins.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
---
 tests/functional/aarch64/test_raspi4.py | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index 0e254a20..69748ce5 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -122,5 +122,37 @@ def test_arm_raspi4_genet(self):
         exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
 
 
+    def test_arm_raspi4_rng_thermal(self):
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
+                         '-no-reboot')
+        self.vm.launch()
+        self.wait_for_console_pattern(
+            'iproc-rng200 fe104000.rng: hwrng registered')
+        self.wait_for_console_pattern('Boot successful.')
+
+        exec_command_and_wait_for_pattern(
+            self, 'cat /sys/devices/virtual/thermal/thermal_zone0/temp',
+            '25310')
+        exec_command_and_wait_for_pattern(self, 'head -c 8 /dev/hwrng | xxd',
+                                                '00000000:')
+        exec_command_and_wait_for_pattern(self, 'halt', 'reboot: System halted')
+
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.47.1


