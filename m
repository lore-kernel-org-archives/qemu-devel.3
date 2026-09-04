Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327F1C79F83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2M6i-0001Bh-DW; Fri, 04 Sep 2026 01:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x2M6d-00019u-82
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x2M6b-0007EO-FG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788498288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=foAT93EZLzPcF51qEkAmQpposvbHKf3J8EM2mCG7Zo8=;
 b=GA/2R5CXszRQv9HVjDUalwXsECnDanRZTaRH5RqC7bpmwcvpcGWabKCnhLG0IGSwFyJvWw
 nNGuhV1UKLsFIL0Vdpmwx7x8jaW73eEmRsnX25zOf6IIsn0ILO18T1aTVJezoeA80GRAUo
 VFGiYE2VV7KqeuG5SnButLynL2oJ1Zs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-tM597H1cNg-rcBXB_BIeTg-1; Fri,
 04 Sep 2026 01:04:43 -0400
X-MC-Unique: tM597H1cNg-rcBXB_BIeTg-1
X-Mimecast-MFC-AGG-ID: tM597H1cNg-rcBXB_BIeTg_1788498281
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4471F188862A; Fri,  4 Sep 2026 05:04:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00B44362; Fri,  4 Sep 2026 05:04:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/2] test/functional: anacapa: test ADC128D818
Date: Fri,  4 Sep 2026 07:04:24 +0200
Message-ID: <20260904050424.4049984-3-clg@redhat.com>
In-Reply-To: <20260904050424.4049984-1-clg@redhat.com>
References: <20260904050424.4049984-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

Verify the ADC128D818 on the Anacapa R-PDB (i2c8 mux channel 0): two
channels are driven with distinct voltages and each is checked to be
reported back independently through the kernel hwmon interface, and the
channel 0 limit registers are validated.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Link: https://lore.kernel.org/qemu-devel/20260707094413.17539-1-emmanuel.blot@free.fr
[ clg: - adjusted on upstream
       - added /machine/labels support ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_anacapa.c             | 11 +++--
 tests/functional/arm/test_aspeed_anacapa.py | 50 +++++++++++++++++++++
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index 65d6b0faa2de..0b8d9cc822ca 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -221,14 +221,15 @@ static const uint8_t hpm_brd_id_eeprom[] = {
 };
 static const size_t hpm_brd_id_eeprom_len = sizeof(hpm_brd_id_eeprom);
 
-static void anacapa_add_adc128d818(I2CBus *bus, uint8_t addr,
+static void anacapa_add_adc128d818(AspeedMachineState *bmc,
+                                   I2CBus *bus, uint8_t addr,
                                    const char *description)
 {
     DeviceState *dev = DEVICE(i2c_slave_new(TYPE_ADC128D818, addr));
     g_autofree char *childname = g_strdup_printf("0x%02x", addr);
 
     qdev_prop_set_string(dev, "description", description);
-    object_property_add_child(OBJECT(bus), childname, OBJECT(dev));
+    aspeed_machine_add_label(bmc, description, OBJECT(dev));
     i2c_slave_realize_and_unref(I2C_SLAVE(dev), bus, &error_fatal);
 }
 
@@ -271,7 +272,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* i2c8mux ch0 */
     /* adc128d818@1f - R-PDB ADC (mode 1: 8 voltage channels) */
-    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 0), 0x1f, "i2c8:0:1f");
+    anacapa_add_adc128d818(bmc, pca954x_i2c_get_bus(i2c_mux, 0),
+                           0x1f, "i2c8:0:1f");
     /* pca9555@22 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
                             TYPE_PCA9552, 0x22);
@@ -333,7 +335,8 @@ static void anacapa_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* i2c13mux ch3 */
     /* adc128d818@1f - MB ADC (mode 1: 8 voltage channels) */
-    anacapa_add_adc128d818(pca954x_i2c_get_bus(i2c_mux, 3), 0x1f, "i2c13:3:1f");
+    anacapa_add_adc128d818(bmc, pca954x_i2c_get_bus(i2c_mux, 3),
+                           0x1f, "i2c13:3:1f");
 
     /* i2c13mux ch4 */
     /* eeprom@51 */
diff --git a/tests/functional/arm/test_aspeed_anacapa.py b/tests/functional/arm/test_aspeed_anacapa.py
index 363b4c2a1d09..0aa00c6f8c86 100644
--- a/tests/functional/arm/test_aspeed_anacapa.py
+++ b/tests/functional/arm/test_aspeed_anacapa.py
@@ -2,10 +2,16 @@
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
 from aspeed import AspeedTest
+from qemu_test import exec_command_and_wait_for_pattern
 
 
 class AnacapaMachine(AspeedTest):
@@ -14,6 +20,10 @@ class AnacapaMachine(AspeedTest):
         'https://github.com/legoater/qemu-aspeed-boot/raw/refs/heads/master/images/anacapa-bmc/openbmc-20260616025349/obmc-phosphor-image-anacapa-20260616025349.static.mtd.xz',
         'de3841fb6ed3085aec6424358ee6efc4b8ee85688361e5aa1987fd1acb7d3fb4')
 
+    ADC128D818_QOM_PATH = "/machine/labels/i2c8:0:1f"
+    ADC128D818_MUX_CHANNEL = "/sys/bus/i2c/devices/8-0072/channel-0"
+    PROMPT = "root@anacapa:~#"
+
     def test_arm_ast2600_anacapa_openbmc(self):
         image_path = self.uncompress(self.ASSET_ANACAPA_FLASH)
 
@@ -21,5 +31,45 @@ def test_arm_ast2600_anacapa_openbmc(self):
                                         uboot='2019.04', cpu_id='0xf00',
                                         soc='AST2600 rev A3')
 
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
+    def wait_adc128d818_value(self, attr, expected):
+        needle = str(expected).encode()
+        if needle in self.read_adc128d818(attr):
+            return
+        time.sleep(2)
+        if needle not in self.read_adc128d818(attr):
+            self.fail(f"{attr} did not reach {expected}")
+
+
 if __name__ == '__main__':
     AspeedTest.main()
-- 
2.55.0


