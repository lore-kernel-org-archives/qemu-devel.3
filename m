Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD893C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 20:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wf1F6-0001tQ-9B; Wed, 01 Jul 2026 16:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1weymr-00009S-Al; Wed, 01 Jul 2026 13:31:56 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1weymp-0007N2-75; Wed, 01 Jul 2026 13:31:48 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 9C5262003C6;
 Wed,  1 Jul 2026 19:31:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1782927105;
 bh=WvcsUh32DCWpKfKABADNif+d9+Y8576yIkWIMEnm4os=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=JwpvvXrYMCc3wsf50cV+EVbgDy7YC/c1LILC/NPsUXmnSElFjR0yt7LaFbV4cHlTW
 WVVM5RL7yge6e40aA7gYBGC1rBSZ8d89GYSn9zmeftViGCgTfV4os282j5NQL1p1V6
 yYguq/e+9spWdG75V4rd2K8WRFxBjsQCJKm6YTZp7TgmfCxBhZg9sNXrvBUAIN64IV
 4yaJlGNMM8cHcnC2888avNixiGFVemWarb87mC1rgKm/gQZXn/XlRpmuOkLLNBl3qv
 DZt4WMrZ0mBq59EC0x7K5IrI1uI71A8tkQt0pgD99mRem4i6+Nh9PT3o1S8910APRG
 dTDwVP1ux7Tdw==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Wed, 01 Jul 2026 19:28:38 +0200
Subject: [PATCH v5 8/8] test/functional: anacapa: test ADC128D818
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-i2c-adc128d818-anacapa-v5-8-fe8292d86b38@free.fr>
References: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
In-Reply-To: <20260701-i2c-adc128d818-anacapa-v5-0-fe8292d86b38@free.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Alexander Hansen <alexander.hansen@9elements.com>, 
 William de Abreu Pinho <williampinho@meta.com>, 
 Emmanuel Blot <eblot@meta.com>, qemu-arm@nongnu.org, 
 Emmanuel Blot <emmanuel.blot@free.fr>, Corey Minyard <cminyard@mvista.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782926919; l=4381;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=WvcsUh32DCWpKfKABADNif+d9+Y8576yIkWIMEnm4os=;
 b=37rA/MpbaXR9yDxdbj6j8SQbKtD3sdw4PXcHboyyoNqeZG/tlVN7Swevu1+p92UWcQZCskyO/
 R5RHi7Cjm2lCaWOG3unoPxvjhj/H0+tCVlI2btI+8FBmCcMtvTsPT7P
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 01 Jul 2026 16:09:06 -0400
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

Verify the ADC128D818 on the Anacapa R-PDB (i2c8 mux channel 0): two
channels are driven with distinct voltages and each is checked to be
reported back independently through the kernel hwmon interface, and the
channel 0 limit registers are validated.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/test_aspeed_anacapa.py | 69 ++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 6 deletions(-)

diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
index 2b72e46b0e..49fab7ad09 100644
--- a/tests/functional/arm/test_aspeed_anacapa.py
+++ b/tests/functional/arm/test_aspeed_anacapa.py
@@ -2,24 +2,81 @@
 #
 # Functional test that boots the ASPEED machines
 #
+# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+#
 # SPDX-License-Identifier: GPL-2.0-or-later
 
+import re
+import time
+
 from qemu_test import Asset
+from qemu_test import exec_command_and_wait_for_pattern
 from aspeed import FacebookAspeedTest
 
 
 class AnacapaMachine(FacebookAspeedTest):
 
     ASSET_ANACAPA_FLASH = Asset(
-        'https://github.com/legoater/qemu-aspeed-boot/raw/c5f585f9f57843c0dc95e3865a57d92ec39cbb0b/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz',
-        'de3841fb6ed3085aec6424358ee6efc4b8ee85688361e5aa1987fd1acb7d3fb4')
+        "https://github.com/legoater/qemu-aspeed-boot/raw/c5f585f9f57843c0dc95e3865a57d92ec39cbb0b/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz",
+        "de3841fb6ed3085aec6424358ee6efc4b8ee85688361e5aa1987fd1acb7d3fb4",
+    )
+
+    ADC128D818_QOM_PATH = \
+        "/machine/soc/i2c/bus[8]/aspeed.i2c.bus.8/0x72/i2c.0/0x1f"
+    ADC128D818_MUX_CHANNEL = "/sys/bus/i2c/devices/8-0072/channel-0"
+    PROMPT = "root@anacapa:~#"
 
     def test_arm_ast2600_anacapa_openbmc(self):
         image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
 
-        self.do_test_arm_aspeed_openbmc('anacapa-bmc', image=image_path,
-                                        uboot='2019.04', cpu_id='0xf00',
-                                        soc='AST2600 rev A3')
+        self.do_test_arm_aspeed_openbmc(
+            "anacapa-bmc",
+            image=image_path,
+            uboot="2019.04",
+            cpu_id="0xf00",
+            soc="AST2600 rev A3",
+        )
 
-if __name__ == '__main__':
+        exec_command_and_wait_for_pattern(self, "root", "Password:")
+        exec_command_and_wait_for_pattern(self, "0penBmc", "#")
+
+        self.adc_hwmon = self.resolve_adc128d818_hwmon()
+        self.assertIn(b"adc128d818", self.read_adc128d818("name"))
+
+        adc = self.ADC128D818_QOM_PATH
+        for ch0_mv, ch1_mv in ((108, 2000), (1280, 500)):
+            self.vm.cmd("qom-set", path=adc, property="ain0", value=ch0_mv)
+            self.vm.cmd("qom-set", path=adc, property="ain1", value=ch1_mv)
+            self.wait_adc128d818_value("in0_input", ch0_mv)
+            self.wait_adc128d818_value("in1_input", ch1_mv)
+
+        self.assertIn(b"2551", self.read_adc128d818("in0_max"))
+        self.assertRegex(self.read_adc128d818("in0_min"), rb"(?m)^0\r*$")
+
+    def resolve_adc128d818_hwmon(self):
+        out = self.read_adc128d818_console(
+            f"basename $(readlink {self.ADC128D818_MUX_CHANNEL})"
+        )
+        match = re.search(rb"i2c-(\d+)", out)
+        self.assertIsNotNone(match, "could not resolve ADC128D818 i2c bus")
+        bus = int(match.group(1))
+        return f"/sys/bus/i2c/devices/{bus}-001f/hwmon/hwmon*"
+
+    def read_adc128d818_console(self, command):
+        return exec_command_and_wait_for_pattern(self, command, self.PROMPT)
+
+    def read_adc128d818(self, attr):
+        return self.read_adc128d818_console(f"cat {self.adc_hwmon}/{attr}")
+
+    def wait_adc128d818_value(self, attr, expected, timeout=20):
+        needle = str(expected).encode()
+        deadline = time.monotonic() + timeout
+        while time.monotonic() < deadline:
+            if needle in self.read_adc128d818(attr):
+                return
+            time.sleep(2)
+        self.fail(f"{attr} did not reach {expected}")
+
+
+if __name__ == "__main__":
     FacebookAspeedTest.main()

-- 
2.50.1


