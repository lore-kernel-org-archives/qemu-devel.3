Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC35FCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIR3v-0002Z0-7R; Sun, 18 Oct 2026 09:36:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3q-0002Ti-NA
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:26 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcelomanzo@gmail.com>)
 id 1xIR3o-0002LG-EK
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:36:26 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-93e6eb77f0bso129551485a.3
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 06:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792330583; x=1792935383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BTLX4E/wXPnRsvyWK12SwwoqMi9TXZxhEIuvci+/7pM=;
 b=C1CCEX4sorARda5BG+Hx6Sa5xScBfQqkUoKu2LwvXQK4aknIyWIp0lmAXrH1Czz6x8
 ovvkLPfpcJAbw8jH+t7iol3x0eApp9CXkA+uLxESBd8bVG8Y6mQGIZzuLyCdr3btXB8Q
 Vn5Lr6T/ePIzQHLuSPAn5DxdjlugeoO+FSpxtMOQERIPMccjF+0GsycNza+ePv5JBU4d
 jUIRm6kByEHaKqbnAnghdtaR1FopZ5a0QGonm68uEcJb6EXrM6gBbmhk1h0f/AiiH0A5
 CxO0PNhLMeb4Ufs0osdkyfbslpuVILphEO3QvsjMYRcRgSvJJLpxhElaqnqQqAhAx6TC
 JWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792330583; x=1792935383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BTLX4E/wXPnRsvyWK12SwwoqMi9TXZxhEIuvci+/7pM=;
 b=v64dX40VanPbKk4IUFGMPhsahjP0+RPusQISbR3PBJN/sgKl8pibZGdOocMfjaHrZ5
 DtMBHqUaiZdGWnMJyAO76afGfqo9PAooVSqsgcUeYfxWMHvQfsaegbsAR1CDDA1lTqJt
 Dgq/lE9r8DkTk9s6GnBil6m20OD209f7TXHMZfF9+Zjs4ZSafkN7zIsH5xY3Ktv32FO+
 PnJdJ6be03aKPjz2eMSkIgFYWKgf0RVk/NWfgi6GH4ndwt9VDUNBqYLjv7YDaokFge7F
 4P9MF6cQseAuOZsiQY+Q0LCKd2clInjMFhQp0BTlR54ALUi5T9kKE+hSZVF2y1fdoGyB
 xdzQ==
X-Gm-Message-State: AFq9FYLY65hcl6tR6GFCimsZHsksdmWRXzPsQTYssIhF3jMyV8JK0nEr
 yzEx96aMXoezhHRNBhjsMy8ctnan9+BTyOeo7LwCxwDtTHOXsAv8amw6Qf2vvOHn
X-Gm-Gg: AYBFou0GfxgaEkVloXO2wdJB0goXLiE7xQsaYYrHmb4viKnihbFr6RmMxnxSvXfpM9U
 DN1TwUuNIFWljPZyh8abmRna3dHmAywuPBJtDEILBGW+EIZclqkcibc+rOb3IvXhs3t2CrThMio
 ynRv4bX1vAbHUvtwHSYWoUcBmzmHYgC1yAiU1OJukiKDGAELwyVkBAnc1j/A5sU7pABCrtA091F
 AAwYfjB9qGwHzciOkbR1O4n6i9bD4MydnjiZealU5ex2fHLCqFCOELJ2gcY0eL5Yly7+HTqiiQV
 KARnYYWLjAmM9/1T25NrtlQdJowhT45t66vL8dMiJ6yCBaSV18dGpxergiJCXX8NOUaINIM1h26
 8IcUQTOdd4SJZE4AoUZ4m9n2GNmWogSbw3FJnbfAoLs53Rk1t314KZXAQb8t09Tk5oz+tIHvb1j
 i+jLjEqEKUxP021onm76rtLUr8eSZE+aT32pdWNq5/35IYZAzakTqYkmOw2tyUYeXNlkAWXa+R9
 IfQYyCmkGOGZrkd0NFg8edhPLUAbrbGMVwjJk1rhtcCBek0RqdwURjpS7nHVyKMX1RQpdc=
X-Received: by 2002:a05:620a:461e:b0:93b:6113:218 with SMTP id
 af79cd13be357-93f29b76073mr807100885a.12.1792330583280; 
 Sun, 18 Oct 2026 06:36:23 -0700 (PDT)
Received: from localhost.localdomain ([2606:6d00:159:2900:ecfc:9d0d:b95b:11bf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93f2a854bb7sm459056485a.23.2026.10.18.06.36.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 18 Oct 2026 06:36:22 -0700 (PDT)
From: Marcelo Manzo <marcelomanzo@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, philmd@oss.qualcomm.com,
 Marcelo Manzo <marcelomanzo@gmail.com>
Subject: [PATCH v4 17/17] tests/functional/aarch64: add raspi4b GENET
 networking test
Date: Sun, 18 Oct 2026 09:36:03 -0400
Message-ID: <20261018133603.64323-18-marcelomanzo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261018133603.64323-1-marcelomanzo@gmail.com>
References: <20261018133603.64323-1-marcelomanzo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=marcelomanzo@gmail.com; helo=mail-qk1-x72e.google.com
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

Add test_arm_raspi4_genet, exercising the raspi4b GENET controller
end to end: boot with a -nic bcm2838-genet device attached, confirm
the guest driver probes it ("GENET 5.0 EPHY" in the kernel log),
reach a shell, and confirm the link actually comes up
("ip link show eth0" reports LOWER_UP) rather than just that the
device exists.

Verified locally against this series with the exact kernel/initrd
assets this file already pins (raspberrypi-kernel_1.20230106-1 /
groeck linux-build-test rootfs). The link only comes up because the
MDIO patch handles the PHY autonegotiation-restart request (BMCR
ANRESTART) correctly; without that the link never comes up and this
test would hang at the "ip link show eth0" step, so it also serves
as a regression test for it.

Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/functional/aarch64/test_raspi4.py | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tests/functional/aarch64/test_raspi4.py b/tests/functional/aarch64/test_raspi4.py
index bacecbbe9c..748837d818 100755
--- a/tests/functional/aarch64/test_raspi4.py
+++ b/tests/functional/aarch64/test_raspi4.py
@@ -109,5 +109,36 @@ def test_arm_raspi4_initrd(self):
         #self.vm.wait()
 
 
+    def test_arm_raspi4_genet(self):
+        self.require_netdev('user')
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
2.55.0


