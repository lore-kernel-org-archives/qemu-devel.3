Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C468C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 07:42:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi5sI-0002a6-VW; Fri, 10 Jul 2026 03:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi5sG-0002ZV-UR; Fri, 10 Jul 2026 03:42:17 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuel.blot@free.fr>)
 id 1wi5sE-00006M-UN; Fri, 10 Jul 2026 03:42:16 -0400
Received: from localhost (unknown [89.92.102.124])
 (Authenticated sender: emmanuel.blot@free.fr)
 by smtp2-g21.free.fr (Postfix) with ESMTPSA id 05B792003ED;
 Fri, 10 Jul 2026 09:41:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1783669332;
 bh=cfQJSmjmzrO00JDyTF/c03sGnlSkqs87kIrzvzuBxog=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=XwjnHiPTEi3wBFLyRLNvTkTnqHimqvN8XAxatSE9T1oREtXatvpigQdwf7NkY1bEt
 /mRZ+f5FdRBYcr3jDBv2Tzh7gq7/m/ri0P1rMGmtn5K+IjKZgqCztfhSPVdScfLeuV
 2/UCMydFu4oQv6wvFMUlKt2DJaJB36NWqMjeglzxaasMq4kT/TZKdX+P9Uhay+Z1e9
 CLvvURTK2C1tCQYN41xfNteCB4FVTXNjqTmWFtHax6ULy3v1+lunyRAR/t3EDrhJdR
 GraUNt/yPcApyID5gjvHFQcjs32y/BArV1MUiJ+qiDrLf92u4rWZGK2fo3OVQf7Q/l
 F5LdB6Vq9gZdA==
From: Emmanuel Blot <emmanuel.blot@free.fr>
Date: Thu, 09 Jul 2026 17:23:17 +0200
Subject: [PATCH 25/29] hw/arm: catalina: add NIC and FIO temperature
 sensors
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-catalina-upgrade-v1-25-82a63fead90c@free.fr>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783610580; l=3192;
 i=emmanuel.blot@free.fr; s=20260602; h=from:subject:message-id;
 bh=cfQJSmjmzrO00JDyTF/c03sGnlSkqs87kIrzvzuBxog=;
 b=hDHCUEmnTjGCqaYei4TISujhvVRMceqVvAZrpnNCHRAylHYqJolDGTR5tq3ei64OxXvtdoI01
 IXeIaQ8mt6nA/dxVqZD0IcjNAJUqxxm+F7N0irIIi+3C66hiNnqxAO7
X-Developer-Key: i=emmanuel.blot@free.fr; a=ed25519;
 pk=0qFrZ21FAAN8OfVsSoVcCFTk/NMYOWzxJz4paSAVm0g=
Received-SPF: pass client-ip=212.27.42.2; envelope-from=emmanuel.blot@free.fr;
 helo=smtp2-g21.free.fr
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Model the temperature sensors described by the Catalina device tree that
have existing QEMU device models but were not yet instantiated: the four
IOB NIC TMP421 sensors behind the i2c0 PCA9546 muxes at 0x71 and 0x75, and
the FIO remote TMP75 sensor at 0x4f on the i2c1 mux.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
---
 hw/arm/aspeed_ast2600_catalina.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index f3b22e9aa9..f714c9d1b3 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -472,7 +472,16 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
 
     /* &i2c0 */
     /* i2c-mux@71 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
+    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x71);
+
+    /* i2c0mux0ch0 */
+    /* IOB0 NIC0 temperature-sensor@1f - tmp421 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
+                            TYPE_TMP421, 0x1f);
+    /* i2c0mux0ch2 */
+    /* IOB0 NIC1 temperature-sensor@1f - tmp421 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2),
+                            TYPE_TMP421, 0x1f);
 
     /* i2c-mux@72 (PCA9546) on i2c0 */
     i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x72);
@@ -489,7 +498,16 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x73);
 
     /* i2c-mux@75 (PCA9546) on i2c0 */
-    i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
+    i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x75);
+
+    /* i2c0mux3ch0 */
+    /* IOB1 NIC0 temperature-sensor@1f - tmp421 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 0),
+                            TYPE_TMP421, 0x1f);
+    /* i2c0mux3ch2 */
+    /* IOB1 NIC1 temperature-sensor@1f - tmp421 */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 2),
+                            TYPE_TMP421, 0x1f);
 
     /* i2c-mux@76 (PCA9546) on i2c0 */
     i2c_mux = i2c_slave_create_simple(i2c[0], TYPE_PCA9546, 0x76);
@@ -544,6 +562,8 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
                           fio_eeprom, fio_eeprom_len);
     /* temperature-sensor@4b - tmp75 */
     i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4b);
+    /* temperature-sensor@4f - tmp75 (FIO remote) */
+    i2c_slave_create_simple(pca954x_i2c_get_bus(i2c_mux, 7), TYPE_TMP75, 0x4f);
 
     /* &i2c2 */
     /* io_expander0 - pca9555@20 */
@@ -564,11 +584,7 @@ static void catalina_bmc_i2c_init(AspeedMachineState *bmc)
     /* eeprom@52 */
     at24c_eeprom_init_rom(pca954x_i2c_get_bus(i2c_mux, 6), 0x52, 8 * KiB,
                           hdd_eeprom, hdd_eeprom_len);
-    /* i2c5mux0ch7 */
-    /* ina230@40 - no model */
-    /* ina230@41 - no model */
-    /* ina230@44 - no model */
-    /* ina230@45 - no model */
+    /* i2c5mux0ch7 - empty */
 
     /* &i2c6 */
     /* io_expander3 - pca9555@21 */

-- 
2.50.1


