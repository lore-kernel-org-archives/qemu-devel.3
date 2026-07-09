Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188A9C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 08:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi6Ly-0001lw-Ib; Fri, 10 Jul 2026 04:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi6Lv-0001lS-Om; Fri, 10 Jul 2026 04:12:55 -0400
Received: from smtp2-g21.free.fr ([2a01:e0c:1:1599::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi6Lt-0001qH-CX; Fri, 10 Jul 2026 04:12:55 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 061DB200401;
 Fri, 10 Jul 2026 10:12:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783671169;
 bh=wnZLqEctjStsBNzE2p5bObpONgfsbApWS1MoOsopwDk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MNt1EtEfsRrKAoljWcbiH2Vzu9YPIrGdbepLnph3CR7iQHmwidLL0Yt/CR1hBZD74
 GEuGAkRdiScgFFspJMCqVOh4+LqXUzSxct9R9DxrM7K/3im8+IvfbCavt/mbV7/RPq
 fTyW7m/dWBNBxmDzXglm3DoBXl64cTTriBdYvFZ5nUw4cXlj07cgrf88AsLdmfv67j
 zYLPre05aIQPvDGLVJD0/IlhSzwtj/HeJ1KAvGj8FoyZUqDBHKvBz8dMEH5oaTedqe
 EzK5Uh0RRe+YXcUtzhXhUqe+xvBZh6L2eSGOf03r9mKla9kssvd/rfC9PrgsJmR4fs
 Wa/vstVocRaHg==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:19 +0200
Subject: [PATCH 27/29] test/functional: catalina: test PCA9555 IO expander
 via QOM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-27-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
In-Reply-To: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Corey Minyard <cminyard@mvista.com>, Emmanuel Blot <emmanuel.blot@free.fr>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=5286;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=wnZLqEctjStsBNzE2p5bObpONgfsbApWS1MoOsopwDk=;
 b=NlJ9wn72/NkE7xz1vQrpvRjjfuOzrOGa7EYHnhdpmlPfs1n9G20VX8pPdQ03wbhWPGf1wmOaX
 QDHAMUk8Z6YA+IZeZ10x0SOUUMa4hT8QTy9aGemlEmdODR0APiQVahH
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=2a01:e0c:1:1599::11;
 envelope-from=emmanuel.blot@free.fr; helo=smtp2-g21.free.fr
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Drive the io_expander0 (pca9555@20 on i2c2) input pins from the host
through the pin%d QOM properties and read each one back both via qom-get
and via the guest kernel gpiochip (libgpiod), spanning both 8-bit ports
and both ends, then check two pins on different ports are reported
independently.

Introduce a check_ioexp() helper doing that round-trip so further
expanders can reuse it. Relies on i2c_slave_create_simple() parenting
slaves under their bus so the expander has a stable QOM path.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 tests/functional/arm/test_aspeed_catalina.py | 74 ++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tests/functional/arm/test_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
index dc2f24e7b43..cf8a59bd2af 100755
--- a/tests/functional/arm/test_aspeed_catalina.py
+++ b/tests/functional/arm/test_aspeed_catalina.py
@@ -2,9 +2,12 @@
 #
 # Functional test that boots the ASPEED machines
 #
+# Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
+#
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import Asset
+from qemu_test import exec_command_and_wait_for_pattern
 from aspeed import AspeedTest
 
 
@@ -14,6 +17,12 @@ class CatalinaMachine(AspeedTest):
         'https://github.com/legoater/qemu-aspeed-boot/raw/a866feb5ef81245b4827a214584bf6bcc72939f6/images/catalina-bmc/obmc-phosphor-image-catalina-20250619123021.static.mtd.xz',
         '287402e1ba021991e06be1d098f509444a02a3d81a73a932f66528b159e864f9')
 
+    PROMPT = "root@catalina:~#"
+
+    # io_expander0: pca9555@20 on i2c2, a 16-bit expander directly on the bus.
+    IOEXP0_QOM = "/machine/soc/i2c/bus[2]/aspeed.i2c.bus.2/0x20"
+    IOEXP0_GPIODETECT = r"\[2-0020\]"
+
     def test_arm_ast2600_catalina_openbmc(self):
         image_path = self.uncompress(self.ASSET_CATALINA_FLASH)
 
@@ -21,5 +30,70 @@ def test_arm_ast2600_catalina_openbmc(self):
                                         uboot='2019.04', cpu_id='0xf00',
                                         soc='AST2600 rev A3')
 
+        exec_command_and_wait_for_pattern(self, 'root', 'Password:')
+        exec_command_and_wait_for_pattern(self, '0penBmc', self.PROMPT)
+
+        # pca9555@20 spans two 8-bit ports (pins 0-7 and 8-15).
+        self.check_ioexp(self.IOEXP0_QOM, self.IOEXP0_GPIODETECT, (0, 7, 8, 15))
+
+    def check_ioexp(self, qom, gpiodetect, pins):
+        # The guest uses these expander lines as inputs (with pull-ups), so
+        # this only exercises the input direction: set_pin injects an external
+        # level and get_pin reports it back from the input register. get_pin
+        # is not checked against a chip-driven output value because the guest
+        # never configures these lines as outputs; that path (the input
+        # register mirroring the OUTPUT register) is covered by the qtests,
+        # which read the same register get_pin returns. set_pin is a no-op on
+        # an output-configured pin, so a passing round-trip also confirms the
+        # lines really are inputs.
+        chip = self.resolve_gpiochip(gpiodetect)
+        for pin in pins:
+            self.set_pin(qom, pin, "low")
+            self.assert_pin(qom, pin, "low")
+            self.assert_gpio_line(chip, pin, 0)
+            self.set_pin(qom, pin, "high")
+            self.assert_pin(qom, pin, "high")
+            self.assert_gpio_line(chip, pin, 1)
+
+        # Drive two pins to opposite levels at once to confirm they are
+        # reported back independently.
+        lo, hi = pins[0], pins[-1]
+        self.set_pin(qom, lo, "low")
+        self.set_pin(qom, hi, "high")
+        self.assert_pin(qom, lo, "low")
+        self.assert_pin(qom, hi, "high")
+        self.assert_gpio_line(chip, lo, 0)
+        self.assert_gpio_line(chip, hi, 1)
+
+    def read_catalina_console(self, command):
+        return exec_command_and_wait_for_pattern(self, command, self.PROMPT)
+
+    def resolve_gpiochip(self, gpiodetect):
+        # awk already prints the "gpiochipN" name; just pick it out of the
+        # console output (the command echo and prompt hold no such token).
+        out = self.read_catalina_console(
+            f"gpiodetect | awk '/{gpiodetect}/{{print $1}}'")
+        for token in out.split():
+            if token.startswith(b"gpiochip"):
+                return token.decode()
+        self.fail(f"could not resolve gpiochip {gpiodetect}")
+
+    def set_pin(self, qom, pin, level):
+        self.vm.cmd("qom-set", path=qom, property=f"pin{pin}", value=level)
+
+    def get_pin(self, qom, pin):
+        return self.vm.cmd("qom-get", path=qom, property=f"pin{pin}")
+
+    def assert_pin(self, qom, pin, expected):
+        level = self.get_pin(qom, pin)
+        self.assertEqual(level, expected,
+                         f"pin{pin} QOM read {level!r}, expected {expected!r}")
+
+    def assert_gpio_line(self, chip, pin, expected):
+        out = self.read_catalina_console(
+            f"echo LINE{pin}=$(gpioget {chip} {pin})")
+        self.assertIn(f"LINE{pin}={expected}".encode(), out)
+
+
 if __name__ == '__main__':
     AspeedTest.main()

-- 
2.50.1


